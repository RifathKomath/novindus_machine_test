import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:novindus_machine_test/core/extensions/margin_extension.dart';
import 'package:novindus_machine_test/core/style/app_text_style.dart';
import 'package:novindus_machine_test/core/style/colors.dart';

import '../../../controller/dash_board/dash_board_controller.dart';

class DateFilterChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashBoardController controller = Get.find<DashBoardController>();
    return Obx(() {
      return InkWell(
        onTap: () => controller.pickDate(context),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 180.w,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(30),
            color: whiteClr,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.formattedDate,
                style: AppTextStyles.textStyle_400_14,
              ),
              8.w.wBox,
              Icon(Icons.keyboard_arrow_down, size: 20, color: primaryColor),
            ],
          ),
        ),
      );
    });
  }
}
