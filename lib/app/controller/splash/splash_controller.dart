import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novindus_machine_test/app/view/dash_board/dash_board_view.dart';
import 'package:novindus_machine_test/app/view/login/login_view.dart';
import 'package:novindus_machine_test/config.dart';
import 'package:novindus_machine_test/shared/utils/screen_utils.dart';

import '../../../core/service/shared_pref.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    scaleAnimation = Tween<double>(begin: 0.100, end: 1.1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.elasticOut),
    );

    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300), () async {
          userDetails = await SharedPref().getUserData();
          accessToken = await SharedPref().loadAccessToken();
          if (userDetails == null) {
            Screen.openAsNewPage(LoginView());
          } else {
            Screen.openAsNewPage(DashBoardView());
          }
        });
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
