import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novindus_machine_test/shared/widgets/app_svg.dart';

import '../../controller/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
   SplashView({super.key});
final SplashController controller = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (_, child) {
            return Opacity(
              opacity: controller.opacityAnimation.value,
              child: Transform.scale(
                scale: controller.scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: AppSvg(assetName: "app_icon")
        ),
      ),
    );
  }
}