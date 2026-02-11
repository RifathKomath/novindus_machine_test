import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:novindus_machine_test/app/controller/login/login_controller.dart';
import 'package:novindus_machine_test/app/view/dash_board/dash_board_view.dart';
import 'package:novindus_machine_test/core/extensions/margin_extension.dart';
import 'package:novindus_machine_test/core/style/app_text_style.dart';
import 'package:novindus_machine_test/shared/utils/screen_utils.dart';
import 'package:novindus_machine_test/shared/utils/validators.dart';
import 'package:novindus_machine_test/shared/widgets/app_button.dart';
import 'package:novindus_machine_test/shared/widgets/app_svg.dart';

import '../../../core/style/colors.dart';
import '../../../shared/widgets/app_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/images/logo_bg.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Center(child: AppSvg(assetName: "app_icon", height: 80)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    20.h.hBox,
                    Text(
                      "Login Or Register To Book Your Appointments",
                      style: AppTextStyles.textStyle_600_14.copyWith(
                        fontSize: 24,
                      ),
                    ),
                    25.h.hBox,
                    AppTextField(
                      controller: controller.emailCntrl,
                      textInputType: TextInputType.emailAddress,
                      labelText: "Enter your Email",
                      label: "Email",
                      useHintInsteadOfLabel: true,
                      validator: AppValidators.required,
                    ),
                    20.h.hBox,
                    Obx(
                      () => AppTextField(
                        controller: controller.passwordCntrl,
                        textInputType: TextInputType.visiblePassword,
                        labelText: "Enter Password",
                        useHintInsteadOfLabel: true,
                        obscureText: !controller.isPasswordVisible.value,
                        label: "Password",
        
                        max: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: darkGrey,
                            size: 23,
                          ),
                          onPressed: () {
                            controller.isPasswordVisible.toggle();
                          },
                        ),
                      ),
                    ),
                    80.h.hBox,
                    Obx(()=>
                      AppButton(
                        isLoaderBtn: controller.isLoading.value,
                        label: "Login",
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.login(context: context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 26, left: 10, right: 10),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text:
                'By creating or logging into an account you are agreeing with our ',
            style: AppTextStyles.textStyle_400_14.copyWith(fontSize: 12),
            children: [
              TextSpan(
                text: 'Terms and Conditions',
                style: AppTextStyles.textStyle_500_14.copyWith(
                  fontSize: 12,
                  color: darkBlue,
                ),
              ),
              TextSpan(
                text: ' and ',
                style: AppTextStyles.textStyle_400_14.copyWith(fontSize: 12),
              ),
              TextSpan(
                text: 'Privacy Policy.',
                style: AppTextStyles.textStyle_500_14.copyWith(
                  fontSize: 12,
                  color: darkBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
