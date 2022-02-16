from django.contrib import admin
from django.urls import include, path
from django.conf.urls.static import static
from django.conf import settings
from users.views import CustomObtainAuthToken

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/', include('users.urls')),
    path('login/', CustomObtainAuthToken.as_view()),
    path('orders/', include('orders.urls')),
    path('products/', include('products.urls')),
    path('cart/', include('cart.urls')),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

admin.site.site_title = 'Lula'
admin.site.index_title = 'Administracion'
admin.site.site_header = 'Lula Administracion'