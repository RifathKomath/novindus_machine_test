import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
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
import 'package:novindus_machine_test/shared/widgets/app_loader.dart';
import 'package:novindus_machine_test/shared/widgets/app_lottie.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          controller.searchByTreatment(
                            controller.searchCntrl.text,
                          );
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
                
                    Flexible(child: DateFilterChip()),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: AppLoader());
              }

              if (controller.patientList.isEmpty) {
                return Center(
                  child: AppLottie(assetName: "No-Data", height: 150),
                );
              }

              return RefreshIndicator(
                color: primaryColor,
                onRefresh: controller.refreshBookings,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.patientList.length,
                  itemBuilder: (context, index) {
                    final data = controller.patientList[index];
                    final subData =
                        data.patientdetailsSet != null &&
                            data.patientdetailsSet!.isNotEmpty
                        ? data.patientdetailsSet!.first
                        : null;

                    return BookingCard(
                      index: index,
                      customerName: data.name ?? "",
                      packageName: subData?.treatmentName ?? "",
                      date: DateFormat(
                        "dd-MM-yyyy",
                      ).format(data.dateNdTime ?? DateTime.now()),
                      staffName: data.user ?? "",
                      onTap: () {
                        Screen.open(PdfPreviewScreen(patient: data));
                      },
                    );
                  },
                  separatorBuilder: (index, context) => 15.hBox,
                ),
              );
            }),
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
