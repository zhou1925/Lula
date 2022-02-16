import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'app/modules/home/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';


void main() async {
  await GetStorage.init('app');
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    GetMaterialApp(
      title: 'Lula',
      debugShowCheckedModeBanner: false,
      // theme: appThemeData,
      theme:  ThemeData(fontFamily: 'Poppins'),
      initialRoute: Routes.INITIAL,
      getPages: AppPages.routes,
      // initialBinding: WelcomeBinding(),
      builder: EasyLoading.init(),
    )
  );
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}