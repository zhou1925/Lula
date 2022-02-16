import 'package:get/get.dart';
import 'package:plant_app/app/data/providers/detail_provider.dart';


class DetailController extends GetxController {
  var product = [].obs;
  RxString tag = ''.obs;
  RxBool isloading = false.obs;
  RxBool cartIsloading = false.obs;

  @override
  void onClose() {
    product.clear();
    super.onClose();
  }

  void loadProduct(String slug) async {
    isloading.value = true;
    var response = await getProductDetail(slug);
    product.clear();
    if(response != null) {
      product.add(response);
      List tag_list = product[0]['tag_list'];
      
      if(tag_list.length > 0) {
        tag.value = product[0]['tag_list'][0]['title'];
      } else {
        tag.value = '';
      }
    }
    // print(product);
    isloading.value = false;
  }
}
