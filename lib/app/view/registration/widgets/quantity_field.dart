import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:novindus_machine_test/core/extensions/margin_extension.dart';
import 'package:novindus_machine_test/core/style/app_text_style.dart';
import 'package:novindus_machine_test/core/style/colors.dart';

import '../../../controller/registration/registration_controller.dart';

class QuantityStepper extends StatelessWidget {
  final RxInt quantity;
  final bool isMale;

  QuantityStepper({
    super.key,
    required this.quantity,
    required this.isMale,
  });

  final RegistrationController controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: isMale
              ? controller.decrement
              : controller.decrementFemale,
          child: Container(
            height: 24,
            width: 24,
            decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.remove, color: whiteClr),
          ),
        ),

        12.w.wBox,

        Obx(() => Container(
              height: 44,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                quantity.value.toString(),
                style: AppTextStyles.textStyle_600_14,
              ),
            )),

        12.w.wBox,

        InkWell(
          onTap: isMale
              ? controller.increment
              : controller.incrementFemale,
          child: Container(
            height: 24,
            width: 24,
            decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
