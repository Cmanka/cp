from django.db.models import Count
from django.views.generic.detail import ContextMixin, SingleObjectMixin

from shop.models import *


class ProductMixin(SingleObjectMixin):

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = f'Product {self.kwargs["pk"]}'
        # context['publications'] = PublishingHouse.objects.get(pk=self.kwargs["pk"]).publication_set.all()
        return context


class ClientMixin(SingleObjectMixin):

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = f'Client {self.kwargs["pk"]}'
        # context['publications'] = PublishingHouse.objects.get(pk=self.kwargs["pk"]).publication_set.all()
        return context


class OrderMixin(SingleObjectMixin):

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = f'Order {self.kwargs["pk"]}'
        # context['publications'] = PublishingHouse.objects.get(pk=self.kwargs["pk"]).publication_set.all()
        return context


class CategoryMixin(SingleObjectMixin):

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = f'Category {self.kwargs["pk"]}'
        # context['publications'] = PublishingHouse.objects.get(pk=self.kwargs["pk"]).publication_set.all()
        return context


class SupplyMixin(SingleObjectMixin):

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = f'Supply {self.kwargs["pk"]}'
        # context['publications'] = PublishingHouse.objects.get(pk=self.kwargs["pk"]).publication_set.all()
        return context


class ProviderMixin(SingleObjectMixin):

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = f'Provider {self.kwargs["pk"]}'
        # context['publications'] = PublishingHouse.objects.get(pk=self.kwargs["pk"]).publication_set.all()
        return context
