import 'dart:ui';
import 'package:plant_app/app/core/theme/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:plant_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:plant_app/app/widgets/alert_dialogs.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // const HomeView({Key? key}) : super(key: key);
  // final CartController cartController = Get.put(CartController());
  final DetailController detailController = Get.put(DetailController());
  // PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
  PageController pageController = PageController(viewportFraction: 0.6, initialPage: 0);
    
    return Scaffold(
      // backgroundColor: Color(0xffF5F5F5),
      backgroundColor: Color(0xfff4f4f4),
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: kGreenLight)
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          items: controller.bottomNavItems,
          height: 60,
          index: controller.bottom_index,
          onTap: (index) {
            controller.goPage(index);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(Icons.sort, size: 35, color: Color(0xff6bc58e)),
                      Text(
                        'Lula', 
                        style: TextStyle(
                          letterSpacing: 2,
                          color: kGreenLight,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      // Icon(Icons.shopping_basket_outlined, size: 35, color: Color(0xff6bc58e))
                    ],
                  ),
                ),      
          
                // divider
                SizedBox(height: 10),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Novedades',
                        style: TextStyle(
                          color: kBlack.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/products');
                        },
                        child: Text(
                          'Ver Todo >',
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          
                // PageBuilder
          
                Obx(
                  () {
                    if(controller.isLoading.value == true) {
                      return Container(height: 320, child: plant_loader(),);
                    }
                    return 
                  
                Container(
                height: 320.0,
                child: PageView.builder(
                  itemCount: controller.lastProducts.length,
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                  padEnds: false,
                  pageSnapping: true,
                  onPageChanged: (value) {
                    controller.activePage.value = value;
                    // print(value);
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        var slug = controller.lastProducts[index]['slug'].toString().toLowerCase();
                        // var productId = controller.lastProducts[index]['id'].toString();
                        detailController.loadProduct(slug);
                        // detailController.loadRelatedProducts(productId);
                        Get.toNamed('/detail');
                      },
                      child: 
                      Obx(
                        () {
                          if(controller.isLoading.value == true){
                            return Container(width: 50,height: 50);
                          }
                          return
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubic,
                        margin: EdgeInsets.all(index == controller.activePage.value ? 10 : 30),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.05),
                              blurRadius: 15,
                              offset: const Offset(5, 5),
                            ),
                          ],
                          border: Border.all(color: green, width: 2),
                          borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                color: lightGreen,
                                boxShadow: [
                                  BoxShadow(
                                    color: black.withOpacity(0.05),
                                    blurRadius: 15,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(25.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(controller.lastProducts[index]['image'])
                                )
                                )
                              ),
                    
                              // Positioned(
                              // right: 8,
                              // top: 8,
                              // child: CircleAvatar(
                              //   backgroundColor: green,
                              //   radius: 15,
                              //   child: Icon(Icons.shopping_cart_outlined, size: 15)
                              // ),
                              // ),
                    
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    // backgroundColor: Colors.green.withOpacity(0.8),
                                    // shadowColor: Color(0x44000000).withOpacity(0.2),
                                    decoration: BoxDecoration(
                                      color: Color(0x44000000).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(25)
                                    ),
                                    child: Text(
                                      'S./ ${controller.lastProducts[index]['price']}',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  )
                                )
                              )
                    
                            ],
                          ),
                        ),
                      );
                      }
                      )
                    );
                    
                  },
                  ),
                );
                }
              ),

              SizedBox(height: 2),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recomendado',
                        style: TextStyle(
                          color: kBlack.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 2),
          
              Obx(
                () {
                  if(controller.randomLoading.value == true) {
                    return Container(height: 100);
                  }
                  return 
              
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: controller.randomProducts.length,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 20.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          var slug = controller.randomProducts[index]['slug'].toString().toLowerCase();
                          detailController.loadProduct(slug);
                          Get.toNamed('/detail');
                        },
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.only(right: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: green.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(controller.randomProducts[index]['image']) 
                                      )
                                    )
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.randomProducts[index]['title'].toString().length < 15 ?
                                        controller.randomProducts[index]['title'] :
                                        '${controller.randomProducts[index]['title'].toString().substring(0,12)}...',
                                        style: TextStyle(
                                          color: kBlack.withOpacity(0.7),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        'S./${controller.randomProducts[index]['price']}',
                                        style: TextStyle(
                                          color: kBlack.withOpacity(0.4),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]
                          )
                        ),
                      );
                    }
                  ),
                );
                }
              ),

              SizedBox(height: 2),
          
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular',
                        style: TextStyle(
                          color: kBlack.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                ),
              ),

            SizedBox(height: 2),
          
            Obx(
                () {
                  if(controller.randomLoadingTwo.value == true) {
                    return Container(height: 100);
                  }
                  return 
              
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: controller.randomProductsTwo.length,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 20.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          var slug = controller.randomProductsTwo[index]['slug'].toString().toLowerCase();
                          detailController.loadProduct(slug);
                          Get.toNamed('/detail');
                        },
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.only(right: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: green.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(controller.randomProductsTwo[index]['image']) 
                                      )
                                    )
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.randomProductsTwo[index]['title'].toString().length < 15 ?
                                        controller.randomProductsTwo[index]['title'] :
                                        '${controller.randomProductsTwo[index]['title'].toString().substring(0,12)}...',
                                        style: TextStyle(
                                          color: kBlack.withOpacity(0.7),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        'S./${controller.randomProductsTwo[index]['price']}',
                                        style: TextStyle(
                                          color: kBlack.withOpacity(0.4),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]
                          )
                        ),
                      );
                    }
                  ),
                );
                }
              ),

              SizedBox(height: 2),
          
              ]
            ),
          )
        ) 
      )
    );
  }
}
