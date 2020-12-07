from django.db import models
from django.urls import reverse
from phonenumber_field.modelfields import PhoneNumberField
from datetime import date, timedelta


class Position(models.Model):
    name = models.CharField(verbose_name='Name', max_length=50, unique=True)
    salary = models.DecimalField(verbose_name='Salary', max_digits=9, decimal_places=2)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Position'
        verbose_name_plural = 'Positions'
        ordering = ['pk']


class Employee(models.Model):
    first_name = models.CharField(verbose_name='First name', max_length=50)
    last_name = models.CharField(verbose_name='Last name', max_length=50)
    middle_name = models.CharField(verbose_name='Middle name', max_length=50)
    email = models.EmailField(verbose_name='Email', max_length=80, unique=True, default='someworkmail@gmail.com')
    phone = PhoneNumberField(verbose_name='Telephone number', unique=True, default='+375333215378')
    position = models.ForeignKey('Position', on_delete=models.PROTECT, default=1)

    def __str__(self):
        return f'{self.last_name} {self.first_name} {self.middle_name}'

    class Meta:
        verbose_name = 'Employee'
        verbose_name_plural = 'Employees'
        ordering = ['pk']

    def get_absolute_url(self):
        return reverse('view_employee', kwargs={'pk': self.pk})


class Client(models.Model):
    first_name = models.CharField(verbose_name='First name', max_length=50)
    last_name = models.CharField(verbose_name='Last name', max_length=50)
    middle_name = models.CharField(verbose_name='Middle name', max_length=50)
    email = models.EmailField(verbose_name='Email', max_length=80, unique=True, default='someworkmail@gmail.com')
    phone = PhoneNumberField(verbose_name='Telephone number', unique=True, default='+375333215378')
    address = models.CharField(verbose_name='Address', max_length=100, unique=True)

    def __str__(self):
        return f'{self.last_name} {self.first_name} {self.middle_name}'

    class Meta:
        verbose_name = 'Client'
        verbose_name_plural = 'Clients'
        ordering = ['pk']

    def get_absolute_url(self):
        return reverse('view_client', kwargs={'pk': self.pk})


class Provider(models.Model):
    name = models.CharField(verbose_name='Name', max_length=100, unique=True)
    representative = models.CharField(verbose_name='Representative', max_length=100)
    email = models.EmailField(verbose_name='Email', max_length=80, unique=True, default='someworkmail@gmail.com')
    phone = PhoneNumberField(verbose_name='Telephone number', unique=True, default='+375333215378')
    address = models.CharField(verbose_name='Address', max_length=100, unique=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Provider'
        verbose_name_plural = 'Providers'
        ordering = ['pk']

    def get_absolute_url(self):
        return reverse('view_provider', kwargs={'pk': self.pk})


class Supply(models.Model):
    provider = models.ForeignKey('Provider', on_delete=models.PROTECT)
    date = models.DateField(verbose_name='Supply date', default=date.today)

    def __str__(self):
        return f'{self.provider.name} {self.date}'

    class Meta:
        verbose_name = 'Supply'
        verbose_name_plural = 'Supplies'
        ordering = ['pk']

    def get_absolute_url(self):
        return reverse('view_supply', kwargs={'pk': self.pk})


class Category(models.Model):
    name = models.CharField(verbose_name='Name', max_length=100, unique=True)
    description = models.TextField(verbose_name='General description', max_length=100)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Category'
        verbose_name_plural = 'Categories'
        ordering = ['pk']

    def get_absolute_url(self):
        return reverse('view_category', kwargs={'pk': self.pk})


class Product(models.Model):
    name = models.CharField(verbose_name='Name', max_length=100, unique=True)
    supply = models.ForeignKey('Supply', on_delete=models.PROTECT)
    category = models.ForeignKey('Category', on_delete=models.PROTECT)
    tech_description = models.CharField(verbose_name='Technical description', max_length=255)
    image = models.ImageField(verbose_name='Image', upload_to='photos/', blank=True, null=True)
    price = models.DecimalField(max_digits=9, decimal_places=2, verbose_name='Price')
    is_on_shop = models.BooleanField(default=True, verbose_name='Product availability')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Product'
        verbose_name_plural = 'Products'
        ordering = ['pk']

    def get_absolute_url(self):
        return reverse('view_product', kwargs={'pk': self.pk})


class Order(models.Model):
    employee = models.ForeignKey('Employee', on_delete=models.PROTECT)
    product = models.ForeignKey('Product', on_delete=models.PROTECT)
    client = models.ForeignKey('Client', on_delete=models.PROTECT)
    start_date = models.DateField(verbose_name='Start date', default=date.today)
    end_date = models.DateField(verbose_name='End date', default=date.today() + timedelta(14))

    def __str__(self):
        return f'Client: {self.client} and date({self.start_date}-{self.end_date})'

    class Meta:
        verbose_name = 'Order'
        verbose_name_plural = 'Orders'
        ordering = ['pk']

    def get_absolute_url(self):
        return reverse('view_order', kwargs={'pk': self.pk})
