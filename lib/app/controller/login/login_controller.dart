import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailCntrl = TextEditingController();
  final TextEditingController passwordCntrl = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  
}
