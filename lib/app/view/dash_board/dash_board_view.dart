import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:novindus_machine_test/app/controller/dash_board/dash_board_controller.dart';
import 'package:novindus_machine_test/app/view/dash_board/widgets/date_chip.dart';
import 'package:novindus_machine_test/app/view/registration/pdf_screen.dart';
import 'package:novindus_machine_test/app/view/registration/registration_view.dart';
import 'package:novindus_machine_test/core/extensions/margin_extension.dart';
import 'package:novindus_machine_test/core/style/app_text_style.dart';
import 'package:novindus_machine_test/core/style/colors.dart';
import 'package:novindus_machine_test/shared/utils/screen_utils.dart';
import 'package:novindus_machine_test/shared/widgets/app_bar.dart';
import 'package:novindus_machine_test/shared/widgets/app_button.dart';
import 'package:novindus_machine_test/shared/widgets/app_search_field.dart';
import 'package:novindus_machine_test/shared/widgets/app_svg.dart';
import 'widgets/booking_card.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final DashBoardController controller = Get.put(DashBoardController());
    return Scaffold(
      appBar: commonAppBar(context: context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppSearchField(
                        controller: controller.searchCntrl,
                        onChanged: (value) {},
                        hintText: "Search for treatments",
                      ),
                    ),
                    15.w.wBox,
                    SizedBox(
                      height: 40,
                      child: AppButton(
                        label: "Search",
                        onTap: () {
                          Screen.open(PdfPreviewScreen());
                        },
                        isExtend: true,
                      ),
                    ),
                  ],
                ),
                20.h.hBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sort by :",
                      style: AppTextStyles.textStyle_500_14.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    DateFilterChip(),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: RefreshIndicator(
                color: primaryColor,
                onRefresh: () async {
                  await controller.refreshBookings();
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BookingCard(
                      index: index,
                      customerName: "Vikram Singh",
                      packageName: "Couple Combo Package (Rejuven...)",
                      date: "31/01/2024",
                      staffName: "Jithesh",
                    );
                  },
                  separatorBuilder: (context, index) => 15.hBox,
                  itemCount: 3,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 5),
        child: AppButton(
          label: "Register Now",
          onTap: () {
            Screen.open(RegistrationView());
          },
        ),
      ),
    );
  }
}

Widget customRawText({required String svgImage, required String text}) {
  return Row(
    spacing: 8,
    children: [
      AppSvg(assetName: svgImage),
      Text(
        text,
        style: AppTextStyles.textStyle_400_14.copyWith(
          fontSize: 15,
          color: blackText.withOpacity(0.75),
        ),
      ),
    ],
  );
}
