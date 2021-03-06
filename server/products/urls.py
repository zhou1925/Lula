from django.urls import path

from .views import ProductViewSet, RelatedProductView, CategoryViewSet, \
                    LastProductsViewSet, RandomProductsViewSet

urlpatterns = [
    path("list/", ProductViewSet.as_view({'get': 'list'})),
    path('last/', LastProductsViewSet.as_view({'get': 'list'})),
    path('random/', RandomProductsViewSet.as_view({'get': 'list'})),
    path("list/<slug>/", ProductViewSet.as_view({'get': 'retrieve'})),
    path("related/<id>/", RelatedProductView.as_view()),
    path("category/", CategoryViewSet.as_view({'get': 'list'})),
    path("category/<id>/", CategoryViewSet.as_view({'get': 'retrieve'})),
]
