from django.contrib import admin

from .models import Order

# admin.site.register(Order)

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'name', 'phone','cart', 'order_code', 'status', 'shipping_total']
    list_filter = ['status', 'timestamp',]
    list_editable = ['status', 'shipping_total']
    search_fields = ['order_code','name', 'user']