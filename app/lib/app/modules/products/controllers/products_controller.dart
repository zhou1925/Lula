import 'package:get/get.dart';

class ProductsController extends GetxController {
  // choice chip value
  RxBool selectedChip = false.obs;
  // Tab
  var selectedTabIndex = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
  }

}
