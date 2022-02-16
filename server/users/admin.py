from django.contrib import admin

from .models import User

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ['id','username','is_active', 'is_staff']
    search_fields = ['username',]
    list_filter = ['is_staff', 'is_active']
    list_editable = ['is_active', 'is_staff']
