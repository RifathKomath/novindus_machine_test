import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/margin_extension.dart';
import '../../../../core/style/app_text_style.dart';
import '../../../../core/style/colors.dart';
import '../../../../shared/widgets/app_close_icon.dart';

class ComboPackageCard extends StatelessWidget {
  final int index;
  final String title;
  final int maleCount;
  final int femaleCount;

  final VoidCallback? onEdit;
  final VoidCallback? onClose;

  const ComboPackageCard({
    super.key,
    required this.index,
    required this.title,
    required this.maleCount,
    required this.femaleCount,

    this.onEdit,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerClr,
      ),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${index + 1}. $title",
                  style: AppTextStyles.textStyle_500_14.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(onTap: onClose, child: AppCloseIcon()),
            ],
          ),

          14.hBox,

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                genderItem("Male", maleCount),
                15.w.wBox,
                genderItem("Female", femaleCount),
                const Spacer(),
                GestureDetector(
                  onTap: onEdit,
                  child: Icon(Icons.edit, color: primaryColor, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget genderItem(String label, int value) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.textStyle_400_14.copyWith(color: primaryColor),
        ),
        5.w.wBox,
        Container(
          height: 30,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.toString(),
            style: AppTextStyles.textStyle_400_14.copyWith(color: primaryColor),
          ),
        ),
      ],
    );
  }
}
