import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_app/app/data/providers/products_provider.dart';


class HomeController extends GetxController {
  // choice chip value
  RxBool selectedChip = false.obs;
  // Tab
  var selectedTabIndex = 0.obs;

  // PageBuilder Controller
  RxInt activePage = 0.obs;

  // Loader
  RxBool isLoading = false.obs;
  RxBool randomLoading = false.obs;
  RxBool randomLoadingTwo = false.obs;


  // bottom nav
  int bottom_index = 0;

  // products
  List lastProducts = [].obs;
  List randomProducts = [].obs;
  List randomProductsTwo = [].obs;

  void onInit() {
    _getProducts();
    _getRandomProducts();
    _getRandomProductsTwo();
    super.onInit();
  }

  _getProducts() async {
    isLoading.value = true;
    var response = await getLastProductsList();
    lastProducts.clear();
    if(response != null) {
      response.forEach((product) {
        lastProducts.add(product);
      });
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  _getRandomProducts() async {
    randomLoading.value = true;
    var response = await getRandomProductList();
    randomProducts.clear();
    if(response != null) {
      response.forEach((product) {
        randomProducts.add(product);
        });
      randomLoading.value = false;
    }
    randomLoading.value = false;
  }

  _getRandomProductsTwo() async {
    randomLoadingTwo.value = true;
    var response = await getRandomProductList();
    randomProductsTwo.clear();
    if(response != null) {
      response.forEach((product) {
        randomProductsTwo.add(product);
        });
      randomLoadingTwo.value = false;
    }
    randomLoadingTwo.value = false;
  }
  
  goPage(index) {
    if(index == 0) {
      bottom_index = index;
      Get.toNamed('/home');
    }
    else if (index == 1) {
      bottom_index = index;
      Get.toNamed('/cart');
    }
    else if (index == 2) {
      bottom_index = index;
      Get.toNamed('/settings');
    }
  }

  final bottomNavItems = [
    Icon(Icons.home_outlined, size: 30),
    Icon(Icons.shopping_cart_outlined, size: 30),
    Icon(Icons.settings_outlined, size: 30),
  ];
}
