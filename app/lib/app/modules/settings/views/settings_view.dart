import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:plant_app/app/core/constants/constants.dart';
import 'package:plant_app/app/modules/settings/widgets/profile_menu.dart';
import 'package:plant_app/app/routes/app_pages.dart';
import 'package:plant_app/app/widgets/custom_app_bar.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Mi cuenta'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 5),

            Account(
              text: 'Actualizar Cuenta',
              press: () {Get.toNamed(Routes.PROFILE);}
            ),
            ProfileMenu(
              text: "Mis Ordenes",
              icon: "assets/icons/parcel.svg",
              press: () {
                Get.toNamed(Routes.ORDERS);
              },
            ),
            ProfileMenu(
              text: "Sobre nosotros",
              icon: "assets/icons/question_mark.svg",
              press: () {
                Get.bottomSheet(Container(
                  // width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Container(
                      width: 300,
                      child: Text(
                        about,
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ),
                )));
              },
            ),
            ProfileMenu(
              text: "Salir",
              icon: "assets/icons/log_out.svg",
              press: () {
                controller.logout();
              },
            ),
          ],
        ),
      )
    );
  }
}
