import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:novindus_machine_test/core/style/colors.dart';
import 'app/controller/splash/splash_controller.dart';
import 'app/view/splash/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SplashController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ayurvedic Centre',
          theme: ThemeData(
          scaffoldBackgroundColor: whiteClr),
          home: SplashView(),
        );
      },
     
    );
  }
}

