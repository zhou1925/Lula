import 'package:get/get.dart';

import 'package:plant_app/app/modules/cart/bindings/cart_binding.dart';
import 'package:plant_app/app/modules/cart/views/cart_view.dart';
import 'package:plant_app/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:plant_app/app/modules/checkout/views/checkout_view.dart';
import 'package:plant_app/app/modules/detail/bindings/detail_binding.dart';
import 'package:plant_app/app/modules/detail/views/detail_view.dart';
import 'package:plant_app/app/modules/home/bindings/home_binding.dart';
import 'package:plant_app/app/modules/home/views/home_view.dart';
import 'package:plant_app/app/modules/initial/bindings/initial_binding.dart';
import 'package:plant_app/app/modules/initial/views/initial_view.dart';
import 'package:plant_app/app/modules/order/bindings/order_binding.dart';
import 'package:plant_app/app/modules/order/views/order_view.dart';
import 'package:plant_app/app/modules/orders/bindings/orders_binding.dart';
import 'package:plant_app/app/modules/orders/views/orders_view.dart';
import 'package:plant_app/app/modules/products/bindings/products_binding.dart';
import 'package:plant_app/app/modules/products/views/products_view.dart';
import 'package:plant_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:plant_app/app/modules/profile/views/profile_view.dart';
import 'package:plant_app/app/modules/settings/bindings/settings_binding.dart';
import 'package:plant_app/app/modules/settings/views/settings_view.dart';
import 'package:plant_app/app/modules/welcome/bindings/welcome_binding.dart';
import 'package:plant_app/app/modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL,
      page: () => InitialView(),
      binding: InitialBinding(),
    ),
  ];
}
