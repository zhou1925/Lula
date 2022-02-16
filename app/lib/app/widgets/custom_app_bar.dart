import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plant_app/app/core/theme/colors.dart';


AppBar CustomAppBar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: kBlack),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/back_arrow.svg',
              width: 24,
              height: 24,
              color: kBlack
            )
          ),
        )
      ),
    );
  }
