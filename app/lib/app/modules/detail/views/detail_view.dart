import 'package:get_storage/get_storage.dart';
import 'package:plant_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:plant_app/app/widgets/alert_dialogs.dart';
import 'package:plant_app/app/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  final CartController cartController = Get.put(CartController());
  final box = GetStorage('app');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Detalles'),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () {
                  if(controller.isloading.value) {
                    return Text('');
                  }
                  return
                  Text(
                    'S./ ${controller.product[0]['price'].toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),
                  );
                }
              ),
              SizedBox(width: 5),

              Obx(
                () =>
              
              Visibility(
                visible: !controller.cartIsloading.value,
                child: GestureDetector(
                  onTap: () async {
                    // print('cart controller add to cart');
                    controller.cartIsloading.value = true;
                    var productId = controller.product[0]['id'].toString();
                    var productQuantity = "1";
                    String token = box.read('token');
                    var response = await http.post(
                      Uri.parse('http://137.184.92.235/cart/'),
                      body:{
                        'id': productId,
                        'quantity': productQuantity
                      },
                      headers: {
                        "Authorization": 'Token ' + token,
                        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
                      }
                    );
                    if (response.statusCode >= 200 && response.statusCode < 300) {
                      show_add_cart_dialog(controller.product[0]['title']);
                    }
                    controller.cartIsloading.value = false;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text('Agregar Al Carro', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 5),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            'assets/icons/add_cart.svg',
                            width: 25,
                            height: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              ),

              Obx(
                () =>
                Visibility(
                  visible: controller.cartIsloading.value,
                  child: Container(
                    
                    child: Row(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  )
                )
              )
            
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Text('Category Plant'),
              // ),

              // SizedBox(height: 20),

              Obx(
                () {
                  if(controller.isloading.value == true) {
                    return Text('');
                  }
                return
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    controller.product[0]['title'],
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w100, 
                    ),
                  ),
                );
               }
              ),
              
              Obx(
                () {
                  if(controller.isloading.value == true) {
                    return Container(height: 350);
                  }
                  return
                
              Container(
                height: 350,
                width: Get.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              controller.product[0]['image']
                            )
                          )
                          )
                        ),
                    ),

                    Expanded(
                      child: Container(
                        color: Colors.white.withOpacity(0.1),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'PRECIO',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'S./ ${controller.product[0]['price'].toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            SizedBox(height: 30),
                            // Text(
                            //   'COLOR',
                            //   style: TextStyle(
                            //     color: Colors.grey,
                            //   ),
                            // ),
                            // Text(
                            //   'White',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 18
                            //   ),
                            // ),
                            // SizedBox(height: 30),
                            Obx(
                              () =>
                                Text(
                                  controller.tag.value.toString().length > 0 ?
                                  'TIPO' : '',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                            ),
                            Obx(
                              () =>
                              Text(
                                controller.tag.value.toString().length > 0 ?
                                controller.tag.toString() : '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              )
                            )
                          ],
                        ),
                      )
                    )
                  ],
                )
               );
               }
              ),

              SizedBox(height: 10),
              // Detalles
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalles',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2
                      ),
                    ),

                    SizedBox(height: 10),
                    Obx(
                      () {
                        if(controller.isloading.value == true) {
                          return Text('');
                        }
                        return
                        Text(
                          controller.product[0]['description'],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        );
                    }
                    ),
                  ],
                ),
              ),

              // Icons
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Container(
              //     height: 50,
              //     width: double.infinity,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Expanded(
              //           child: Container(
              //             child: Row(
              //               children: [
              //                 Icon(Icons.timelapse),
              //                 Text('Medium')
              //               ],
              //             ),
              //           )
              //         ),
              //         Expanded(
              //           child: Container(
              //             child: Row(
              //               children: [
              //                 Icon(Icons.brightness_7_outlined),
              //                 Text('12 sunny')
              //               ],
              //             ),
              //           )
              //         ),
              //         Expanded(
              //           child: Container(
              //             child: Row(
              //               children: [
              //                 Icon(Icons.home_outlined),
              //                 Text('Indooe')
              //               ],
              //             ),
              //           )
              //         )
              //       ],
              //     ),
              //   ),
              // )

            ],
          )
        )
      )
    );
  }
}
