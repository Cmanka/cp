from django.contrib.auth import login, logout
from django.db import connection
from django.forms import Form
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import *
from .mixins import *
from .forms import *
import datetime
from weasyprint import HTML
import tempfile
from django.template.loader import render_to_string


class IndexView(ListView):
    queryset = object
    template_name = 'shop/index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Home page'
        context['models_employee'] = {
            'Products': ['all information about products', 'https://i.ibb.co/g9Dx3jy/untitled.png', 'Add_Product'],
            'Clients': ['all information about clients', 'https://i.ibb.co/gwyx23N/untitled-1.png', 'Add_Client'],
            'Orders': ['all information about orders', 'https://i.ibb.co/m6tcVS8/untitled-2.png', 'Add_Order'],
            'Categories': ['all information about categories', 'https://i.ibb.co/tDBPJ09/untitled-3.png',
                           'Add_Category']}
        context['models_superusers'] = {
            'Products': ['all information about products', 'https://i.ibb.co/g9Dx3jy/untitled.png'],
            'Clients': ['all information about clients', 'https://i.ibb.co/gwyx23N/untitled-1.png'],
            'Orders': ['all information about orders', 'https://i.ibb.co/m6tcVS8/untitled-2.png'],
            'Categories': ['all information about categories', 'https://i.ibb.co/tDBPJ09/untitled-3.png'],
            'Supplies': ['all information about supplies', 'https://i.ibb.co/qp5gVn1/untitled-4.png'],
            'Providers': ['all information about providers', 'https://i.ibb.co/PFq6BbK/untitled-5.png']}
        context['product'] = 'Add_Product'
        return context


class ProductsView(ListView):
    Model = Product
    context_object_name = 'products'
    template_name = 'shop/products_directory/products.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Products page'
        return context

    def get_queryset(self):
        return Product.objects.all()


class ProductByIdView(ProductMixin, DetailView):
    model = Product
    context_object_name = 'product'
    template_name = 'shop/products_directory/product.html'


class CreateProductView(CreateView):
    form_class = ProductForm
    template_name = 'shop/products_directory/add_product.html'
    success_url = reverse_lazy('Products')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new product'
        return context


class EditProductView(UpdateView):
    model = Product
    form_class = ProductForm
    template_name = 'shop/products_directory/edit_product.html'
    success_url = reverse_lazy('Products')

    def form_valid(self, form):
        form.save(commit=True)
        return super(EditProductView, self).form_valid(form)


class DeleteProductView(DeleteView):
    model = Product
    template_name = 'shop/products_directory/confirm_delete_product.html'
    success_url = reverse_lazy('Products')


class ClientsView(ListView):
    Model = Client
    context_object_name = 'clients'
    template_name = 'shop/clients_directory/clients.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Clients page'
        return context

    def get_queryset(self):
        return Client.objects.all()


class ClientByIdView(ClientMixin, DetailView):
    model = Client
    context_object_name = 'client'
    template_name = 'shop/clients_directory/client.html'


class CreateClientView(CreateView):
    form_class = ClientForm
    template_name = 'shop/clients_directory/add_client.html'
    success_url = reverse_lazy('Clients')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new client'
        return context


class EditClientView(UpdateView):
    model = Client
    form_class = ClientForm
    template_name = 'shop/clients_directory/edit_client.html'
    success_url = reverse_lazy('Clients')


class DeleteClientView(DeleteView):
    model = Client
    template_name = 'shop/clients_directory/confirm_delete_client.html'
    success_url = reverse_lazy('Clients')


class OrdersView(ListView):
    Model = Order
    context_object_name = 'orders'
    template_name = 'shop/orders_directory/orders.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Orders page'
        return context

    def get_queryset(self):
        return Order.objects.all()


class OrderByIdView(OrderMixin, DetailView):
    model = Order
    context_object_name = 'order'
    template_name = 'shop/orders_directory/order.html'


class CreateOrderView(CreateView):
    form_class = OrderForm
    template_name = 'shop/orders_directory/add_order.html'
    success_url = reverse_lazy('Orders')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new order'
        return context


class EditOrderView(UpdateView):
    model = Order
    form_class = OrderForm
    template_name = 'shop/orders_directory/edit_order.html'
    success_url = reverse_lazy('Orders')


class DeleteOrderView(DeleteView):
    model = Order
    template_name = 'shop/orders_directory/confirm_delete_order.html'
    success_url = reverse_lazy('Orders')


class CategoriesView(ListView):
    Model = Category
    context_object_name = 'categories'
    template_name = 'shop/categories_directory/categories.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Categories page'
        return context

    def get_queryset(self):
        return Category.objects.all()


class CategoryByIdView(CategoryMixin, DetailView):
    model = Category
    context_object_name = 'category'
    template_name = 'shop/categories_directory/category.html'


class CreateCategoryView(CreateView):
    form_class = CategoryForm
    template_name = 'shop/categories_directory/add_category.html'
    success_url = reverse_lazy('Categories')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Add new category'
        return context


class EditCategoryView(UpdateView):
    model = Category
    form_class = CategoryForm
    template_name = 'shop/categories_directory/edit_category.html'
    success_url = reverse_lazy('Categories')


class DeleteCategoryView(DeleteView):
    model = Category
    template_name = 'shop/categories_directory/confirm_delete_category.html'
    success_url = reverse_lazy('Categories')


class SuppliesView(ListView):
    Model = Supply
    context_object_name = 'supplies'
    template_name = 'shop/supplies_directory/supplies.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Supplies page'
        return context

    def get_queryset(self):
        return Supply.objects.all()


class SupplyByIdView(SupplyMixin, DetailView):
    model = Supply
    context_object_name = 'supply'
    template_name = 'shop/supplies_directory/supply.html'


class ProvidersView(ListView):
    Model = Provider
    context_object_name = 'providers'
    template_name = 'shop/providers_directory/providers.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Providers page'
        return context

    def get_queryset(self):
        return Provider.objects.all()


class ProviderByIdView(ProviderMixin, DetailView):
    model = Provider
    context_object_name = 'provider'
    template_name = 'shop/providers_directory/provider.html'


class ReportView(ListView):
    Model = Employee
    context_object_name = 'employees'
    template_name = 'shop/report_directory/report.html'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Report page'
        return context

    def get_queryset(self):
        return Employee.objects.all()


def export_pdf(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'inline; attachment; filename-Expenses' + \
                                      str(datetime.datetime.now()) + '.pdf'
    response['Content-Transfer-Encoding'] = 'binary'

    employees = Employee.objects.all()

    html_string = render_to_string('shop/report_directory/pdf-output.html', {'employees': employees, 'text': 'text'})
    html = HTML(string=html_string)

    result = html.write_pdf()

    with tempfile.NamedTemporaryFile(delete=True) as output:
        output.write(result)
        output.flush()
        output = open(output.name, 'rb')
        response.write(output.read())

    return response


def user_login(request):
    if request.method == 'POST':
        form = UserLoginForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('home')
    else:
        form = UserLoginForm()
    return render(request, 'shop/authorization_directory/login.html', {'form': form})


def user_logout(request):
    logout(request)
    return redirect('login')


class QueriesIndexView(ListView):
    queryset = object
    template_name = 'shop/queries_directory/index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Queries page'
        context['queries'] = {
            'Get count of the employees': 'get_count_employees',
            'Get products by provider name': 'get_product_by_provider_name',
            'Get products where price > [price]': 'get_products_where_price_more',
            'Get products in the shop': 'get_products_in_shop',
        }
        return context


def get_count_employees(request):
    if request.method == 'POST':
        with connection.cursor() as c:
            c.callproc('get_count_employees', )
            result = c.fetchall()
        context = {'result': result, 'title': 'Query result'}
        return render(request, 'shop/queries_directory/get_count_employees/result.html', context)
    else:
        query_form = Form()
        context = {'form': query_form, 'title': 'Get count of employees'}
        return render(request, 'shop/queries_directory/get_count_employees/query.html', context)


def get_products_by_provider_name(request):
    if request.method == 'POST':
        name = request.POST.get("provider_name")
        with connection.cursor() as c:
            c.callproc('get_product_by_provider_name ', [name])
            results = c.fetchall()
        context = {'results': results, 'title': 'Query result'}
        return render(request, 'shop/queries_directory/get_product_by_provider_name/result.html', context)
    else:
        query_form = ProvidersQueryForm()
        providers = Provider.objects.all()
        query_form.fields['provider_name'].choices = [(name.name, name.name) for
                                                      name in providers]
        context = {'form': query_form, 'title': 'Get products by provider name'}
        return render(request, 'shop/queries_directory/get_product_by_provider_name/query.html', context)


def get_products_where_price_more(request):
    if request.method == 'POST':
        price = request.POST.get("more_price")
        with connection.cursor() as c:
            c.callproc('get_product_where_price_more ', [price])
            results = c.fetchall()
        context = {'results': results, 'title': 'Query result'}
        return render(request, 'shop/queries_directory/get_product_where_price_more/result.html', context)
    else:
        query_form = ProductQueryForm()
        context = {'form': query_form, 'title': 'Get products where price more'}
        return render(request, 'shop/queries_directory/get_product_where_price_more/query.html', context)


def get_products_in_shop(request):
    if request.method == 'POST':
        with connection.cursor() as c:
            c.callproc('get_products_in_shop', )
            result = c.fetchall()
        context = {'results': result, 'title': 'Query result'}
        return render(request, 'shop/queries_directory/get_products_in_shop/result.html', context)
    else:
        query_form = Form()
        context = {'form': query_form, 'title': 'Get products in the shop'}
        return render(request, 'shop/queries_directory/get_products_in_shop/query.html', context)
