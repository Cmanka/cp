from django.contrib import admin
from .models import *


class PositionAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'salary')
    list_display_links = ('id', 'name', 'salary')


class EmployeeAdmin(admin.ModelAdmin):
    list_display = ('id', 'first_name', 'last_name', 'middle_name', 'email', 'phone', 'position')
    list_display_links = ('id', 'first_name', 'last_name', 'middle_name', 'email', 'phone', 'position')


class ClientAdmin(admin.ModelAdmin):
    list_display = ('id', 'first_name', 'last_name', 'middle_name', 'email', 'phone', 'address')
    list_display_links = ('id', 'first_name', 'last_name', 'middle_name', 'email', 'phone', 'address')


class ProviderAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'representative', 'email', 'phone', 'address')
    list_display_links = ('id', 'name', 'representative', 'email', 'phone', 'address')


class SupplyAdmin(admin.ModelAdmin):
    list_display = ('id', 'provider', 'date')
    list_display_links = ('id', 'provider', 'date')


class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'description')
    list_display_links = ('id', 'name', 'description')


class ProductAdmin(admin.ModelAdmin):
    list_display = (
        'id', 'name', 'supply', 'category', 'tech_description', 'price', 'is_on_shop')
    list_display_links = (
        'id', 'name', 'supply', 'category', 'tech_description', 'price', 'is_on_shop')


class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'employee', 'product', 'client', 'start_date', 'end_date')
    list_display_links = ('id', 'employee', 'product', 'client', 'start_date', 'end_date')


admin.site.register(Position, PositionAdmin)
admin.site.register(Employee, EmployeeAdmin)
admin.site.register(Client, ClientAdmin)
admin.site.register(Provider, ProviderAdmin)
admin.site.register(Supply, SupplyAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(Product, ProductAdmin)
admin.site.register(Order, OrderAdmin)
