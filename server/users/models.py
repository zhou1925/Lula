from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, \
                                        PermissionsMixin

class UserMananager(BaseUserManager):

    def create_user(self, username, password=None, **extra_fields):
        """Create and save a new user"""
        if not username:
            raise ValueError('Users must be have a username ')
        user = self.model(username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user
    
    def create_superuser(self, username, password, **extra_fields):
        """ Create super user and save """
        user = self.create_user(username=username, password=password)
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user 
    

class User(AbstractBaseUser, PermissionsMixin):
    """Custom user model that supports username"""
    username = models.CharField('Nombre Usuario',max_length=12, unique=True)
    address = models.CharField('Direccion',max_length=255, blank=True, null=True)
    # phone = models.CharField(max_length=9, blank=True, null=True)
    is_active = models.BooleanField('Activo', default=True)
    is_staff = models.BooleanField('Staff',default=False)

    objects = UserMananager()

    USERNAME_FIELD = 'username'

    class Meta:
        verbose_name = 'Usuario'
        verbose_name_plural = 'Usuarios'
