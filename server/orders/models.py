from django.db import models
from django.contrib.auth import get_user_model
from django.db.models.signals import pre_save
from cart.models import Cart
from server.utils import unique_product_id_generator

User = get_user_model()

STATUS_CHOICES = (
    ('created', 'Created'),
    ('received', 'Received'),
    ('shipped', 'Shipped'),
    ('paid', 'Paid'),
    ('refunded', 'Refunded'),
    ('canceled', 'Canceled')
)

class OrderManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter()


class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField('Nombre', max_length=255)
    address_line_1 = models.CharField('Direccion 1', max_length=255)
    address_line_2 = models.CharField('Direccion 2', max_length=255, blank=True, null=True)
    order_code = models.CharField('Codigo de orden', max_length=120, blank=True)
    phone = models.CharField('Telefono', max_length=9)
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    active = models.BooleanField('Activo', default=True)
    status = models.CharField('Estado',choices=STATUS_CHOICES, default='created', max_length=120)
    timestamp = models.DateTimeField('Fecha',auto_now_add=True)
    shipping_total = models.DecimalField('Costo de envio',default=0, max_digits=10, decimal_places=2)

    objects = OrderManager()
    
    def __str__(self):
        return "{}".format(self.id)

    @property
    def total_in_pen(self):
        return int(self.total * 100)

    def check_done(self):
        user = self.user
        total = self.total
        cart = self.cart
        active = self.active
        if active and total > 0 and cart and user:
            return True
        return False

    def mark_used_cart(self):
        if self.check_done():
            self.cart.used = True
            self.cart.save()
            self.status = 'created'
            self.save()
            return True
        return False

    def mark_paid(self):
        if self.check_done():
            self.cart.used = True
            self.cart.save()
            self.status = 'paid'
            self.save()
            return True
        return False

    @property
    def cart_total(self):
        return self.cart.total

    @property
    def tax_total(self):
        return self.cart.tax_total

    @property
    def total(self):
        return float(self.cart_total) + float(self.shipping_total)
    
    class Meta:
        verbose_name = 'Orden'
        verbose_name_plural = 'Ordenes'


def pre_save_create_order_code(sender, instance, *args, **kwargs):
    if not instance.order_code:
        instance.order_code = unique_product_id_generator(instance)


pre_save.connect(pre_save_create_order_code, sender=Order)