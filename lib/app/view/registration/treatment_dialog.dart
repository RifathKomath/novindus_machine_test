import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:novindus_machine_test/app/model/registration/get_treatment_response.dart';
import 'package:novindus_machine_test/core/extensions/margin_extension.dart';
import 'package:novindus_machine_test/core/style/colors.dart';
import 'package:novindus_machine_test/shared/utils/screen_utils.dart';
import 'package:novindus_machine_test/shared/widgets/app_button.dart';

import '../../../shared/utils/validators.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/common_dropdown.dart';
import '../../controller/registration/registration_controller.dart';
import 'widgets/quantity_field.dart';

class TreatmentDialog extends StatelessWidget {
  const TreatmentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller =
        Get.find<RegistrationController>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      insetPadding: EdgeInsets.all(15),
      backgroundColor: whiteClr,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                return CustomDropdown<Treatment>(
                  selectedValue: controller.selectedTreatment.value,
                  items: controller.treatmentList,
                  itemToString: (treatment) => treatment.name ?? "",
                  w: double.infinity,
                  onChanged: (value) {
                    controller.selectedTreatment.value = value;
                    controller.selectedTreatmentId.value =
                        value?.id?.toString() ?? "";
                  },
                  hint: "Choose prefered treatment",
                  isSelectedValid: true,
                  headingText: "Choose Treatment",
                  showHeading: true,
                  validator: AppValidators.requiredObject,
                );
              }),
              20.h.hBox,
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: controller.teatment1Cntrl,
                      textInputType: TextInputType.name,
                      labelText: "Male",
                      useHintInsteadOfLabel: true,
                      label: "Add Patients",
                      readOnly: true,
                    ),
                  ),
                  15.w.wBox,
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: QuantityStepper(
                      quantity: controller.quantity,
                      isMale: true,
                    ),
                  ),
                ],
              ),
              20.h.hBox,
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: controller.teatment2Cntrl,
                      textInputType: TextInputType.name,
                      labelText: "Female",
                      useHintInsteadOfLabel: true,
                      readOnly: true,
                    ),
                  ),
                  15.w.wBox,
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: QuantityStepper(
                      quantity: controller.quantity2,
                      isMale: false,
                    ),
                  ),
                ],
              ),
              40.h.hBox,
              AppButton(
                label: "Save",
                onTap: () {
                  controller.addComboPackage("${controller.selectedTreatment.value?.name}");
                  Screen.close();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
