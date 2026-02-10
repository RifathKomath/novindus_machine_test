import 'package:flutter/material.dart';

import '../../../../core/extensions/margin_extension.dart';
import '../../../../core/style/app_text_style.dart';
import '../../../../core/style/colors.dart';
import '../dash_board_view.dart';

class BookingCard extends StatelessWidget {
  final int index;
  final String customerName;
  final String packageName;
  final String date;
  final String staffName;
  final VoidCallback? onTap;

  const BookingCard({
    super.key,
    required this.index,
    required this.customerName,
    required this.packageName,
    required this.date,
    required this.staffName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerClr,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${index + 1}. $customerName",
                  style: AppTextStyles.textStyle_500_14
                      .copyWith(fontSize: 18),
                ),
                4.hBox,
                Text(
                  packageName,
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ).paddingSymmetricHorizontal(22),
                8.hBox,
                Row(
                  spacing: 10,
                  children: [
                    customRawText(
                      svgImage: "cal_icon",
                      text: date,
                    ),
                    customRawText(
                      svgImage: "person_icon",
                      text: staffName,
                    ),
                  ],
                ).paddingSymmetricHorizontal(22),
              ],
            ),
          ),
          const Divider(),
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "View Booking details",
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 17,
                  color: primaryColor,
                ),
              ],
            ).paddingSymmetricHorizontal(36),
          ),
          12.hBox,
        ],
      ),
    );
  }
}
