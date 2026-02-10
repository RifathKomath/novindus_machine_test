import 'package:flutter/material.dart';
import 'package:novindus_machine_test/shared/widgets/app_svg.dart';
import '../../core/extensions/margin_extension.dart';
import '../../core/style/app_text_style.dart';
import '../../core/style/colors.dart';
import '../utils/screen_utils.dart';

PreferredSizeWidget commonAppBar({
  bool? isBack,
  bool? isbottom,
  String? bottomTitle,
  required BuildContext context,
}) {
  return AppBar(
    backgroundColor: whiteClr,
    iconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: isBack ?? false,
    leading: isBack == true
        ? GestureDetector(
            onTap: () => Screen.close(),
            child: const Icon(Icons.arrow_back_outlined),
          )
        : null,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: AppSvg(assetName: "bell_icon_not"),
      ),
    ],
    bottom: isbottom == true
        ? PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bottomTitle ?? "",
                  style: AppTextStyles.textStyle_600_14.copyWith(fontSize: 24),
                ).paddingSymmetricHorizontal(34),
                8.hBox,
                Divider(),
              ],
            ),
          )
        : null,
    forceMaterialTransparency: true,
  );
}
