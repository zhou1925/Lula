import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:plant_app/app/core/theme/colors.dart';
import 'package:plant_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:plant_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:plant_app/app/modules/home/controllers/tag_controller.dart';
import 'package:plant_app/app/routes/app_pages.dart';
import 'package:plant_app/app/widgets/alert_dialogs.dart';
import 'package:plant_app/app/widgets/custom_app_bar.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  final TagController tagController = Get.put(TagController());
  final CartController cartController = Get.put(CartController());
  final DetailController detailController = Get.put(DetailController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffece9e9),
      appBar: CustomAppBar('Plantas'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Container(
                  height: 50,
                  child: 
                  Obx(
                    () {
                      // if(tagController.isloading.value == true) {
                      //   return Text('');
                      // }
                      return      
                  ListView.builder(
                    itemCount: tagController.categories.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // print(index);
                              controller.selectedTabIndex.value = index;
                              tagController.loadData((index + 1).toString());
                            },
                            child: Obx(
                              () =>
                                  Chip(
                                    backgroundColor: index == controller.selectedTabIndex.value ? Colors.white : Color(0xff0d1321),
                                    label: Text(
                                      tagController.categories[index]['title'],
                                      style: TextStyle(
                                        color: index == controller.selectedTabIndex.value ? kBlack : Color(0xffd3dcde).withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14
                                      ),
                                    ),
                                  ),
                            ) 
                          ),
                        ]
                        )
                      ),
                    );
                    }
                  )
                  ),

                SingleChildScrollView(
                  child: Container(
                    width: Get.width - 50,
                    height: Get.height - 150,
                    child: 
                    Obx(
                      () {
                        if(tagController.isloading.value == true) {
                          return plant_loader();
                        }
                      return
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: tagController.categoryDataDetail.length,
                      itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                var slug = tagController.categoryDataDetail[index]['slug'].toString().toLowerCase();
                                // var productId = tagController.categoryDataDetail[index]['id'].toString();
                                detailController.loadProduct(slug);
                                // detailController.loadRelatedProducts(productId);
                                Get.toNamed(Routes.DETAIL);
                              },
                              child: Container(
                                width: 350,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10, right: 5,
                                      ),
                                      child: Container(
                                        width: 80,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xffe8f6ee),
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(tagController.categoryDataDetail[index]['image'])
                                          )
                                        ),
                                        
                                      ),
                                    ),
                            
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            child: Text(
                                              tagController.categoryDataDetail[index]['title'].toString().length < 17 ?
                                              tagController.categoryDataDetail[index]['title'].toString() : 
                                              '${tagController.categoryDataDetail[index]['title'].toString().substring(0,12)}...',
                                              style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff6bc58e)
                                              ),
                                              )
                                            ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: Get.width / 2.3,
                                            height: 40,
                                            child: Text(
                                              '${tagController.categoryDataDetail[index]['description']}',
                                              softWrap: true,
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                              ),
                                              )
                                            ),
                                          SizedBox(height: 10),
                                          Row(
                                            
                                            
                                            children: [
                                              Container(
                                                child: Text(
                                                  'S./${tagController.categoryDataDetail[index]['price']}',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14
                                                  ),
                                                )
                                              ),

                                            ]
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    );
                   }
                  )
                  ),
                ),

            ],
          ),
        ),
      )
    );
  }
}
