import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:plant_app/app/core/theme/colors.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../controllers/initial_controller.dart';

// ignore: must_be_immutable
class InitialView extends GetView<InitialController> {
  InitialController controller = Get.put(InitialController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
          Container(
            margin: EdgeInsets.all(50),
            child: Center(
              child: OpacityAnimatedWidget(
                enabled: true,
                values: [0,1],
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
                child: Text(
                  'Lula',
                  style: TextStyle(
                    color: kGreenLight,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ]
        ),
      )
    );
  }
}
