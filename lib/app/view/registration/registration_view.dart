import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:novindus_machine_test/app/controller/registration/registration_controller.dart';
import 'package:novindus_machine_test/app/view/registration/treatment_dialog.dart';
import 'package:novindus_machine_test/core/extensions/margin_extension.dart';
import 'package:novindus_machine_test/core/style/app_text_style.dart';
import 'package:novindus_machine_test/core/style/colors.dart';
import 'package:novindus_machine_test/shared/widgets/app_button.dart';
import 'package:novindus_machine_test/shared/widgets/common_dropdown.dart';
import '../../../shared/utils/validators.dart';
import '../../../shared/widgets/app_bar.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../model/registration/get_branch_response.dart';
import 'widgets/list_card.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.put(RegistrationController());
    final List<String> keralaDistricts = [
      "Thiruvananthapuram",
      "Kollam",
      "Pathanamthitta",
      "Alappuzha",
      "Kottayam",
      "Idukki",
      "Ernakulam",
      "Thrissur",
      "Palakkad",
      "Malappuram",
      "Kozhikode",
      "Wayanad",
      "Kannur",
      "Kasaragod",
    ];
    final List<String> hours12 = List.generate(
      12,
      (index) => ((index + 1).toString().padLeft(2, '0')),
    );
    final List<String> minutes = List.generate(
      12,
      (index) => (index * 5).toString().padLeft(2, '0'),
    );
    final List<String> amPm = ['AM', 'PM'];

    return Scaffold(
      appBar: commonAppBar(
        context: context,
        isBack: true,
        isbottom: true,
        bottomTitle: "Register",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: controller.fullNameCntrl,
                  textInputType: TextInputType.name,
                  labelText: "Enter your full name",
                  useHintInsteadOfLabel: true,
                  label: "Name",
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                    FilteringTextInputFormatter.deny(RegExp(r'[^\sa-zA-Z]')),
                  ],
                  validator: AppValidators.required,
                ),
                20.h.hBox,
                AppTextField(
                  controller: controller.whtapNoCntrl,
                  textInputType: TextInputType.number,
                  labelText: "Enter your Whatsapp Number",
                  useHintInsteadOfLabel: true,
                  maxLength: 10,
                  label: "Whatsapp Number",
                  validator: AppValidators.required,
                ),
                20.h.hBox,
                AppTextField(
                  controller: controller.addressCntrl,
                  textInputType: TextInputType.streetAddress,
                  labelText: "Enter your full Address",
                  useHintInsteadOfLabel: true,
                  label: "Address",
                  textCapitalization: TextCapitalization.words,
                  validator: AppValidators.required,
                ),
                20.h.hBox,
                CustomDropdown<String>(
                  selectedValue: controller.selectedLocation.value.isEmpty
                      ? null
                      : controller.selectedLocation.value,
                  items: keralaDistricts,
                  w: double.infinity,
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedLocation.value = value;
                    }
                  },
                  hint: "Choose your location",
                  isSelectedValid: true,
                  headingText: "Location",
                  showHeading: true,
                  validator: AppValidators.required,
                ),
                20.h.hBox,
                Obx(() {
                  return CustomDropdown<BranchData>(
                    selectedValue: controller.selectedBranch.value,
                    items: controller.branchList,
                    itemToString: (branch) => branch.name ?? "",
                    w: double.infinity,
                    onChanged: (value) {
                      controller.selectedBranch.value = value;
                      controller.selectedBranchId.value =
                          value?.id?.toString() ?? "";
                    },
                    hint: "Select the branch",
                    isSelectedValid: true,
                    headingText: "Branch",
                    showHeading: true,
                    validator: AppValidators.requiredObject,
                  );
                }),

                20.h.hBox,
                Text(
                  "Treatments",
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

                Obx(() {
                  if (controller.comboList.isEmpty) {
                    return 0.hBox;
                  }
                  return Column(
                    children: [
                      10.h.hBox,
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = controller.comboList[index];

                          return ComboPackageCard(
                            index: index,
                            title: item.name ?? "",
                            maleCount: item.maleCount ?? 0,
                            femaleCount: item.femaleCount ?? 0,
                            onEdit: () {
                              controller.selectedTreatment.value = controller
                                  .treatmentList
                                  .firstWhereOrNull(
                                    (t) => t.id?.toString() == item.id,
                                  );
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    TreatmentDialog(comboToEdit: item),
                              );
                            },
                            onClose: () {
                              controller.removeCombo(index);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return 15.hBox;
                        },
                        itemCount: controller.comboList.length,
                      ),
                    ],
                  );
                }),
                10.h.hBox,
                AppButton(
                  label: "+ Add Treatments",
                  onTap: () {
                    controller.selectedTreatment.value = null;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return TreatmentDialog();
                      },
                    );
                  },
                ),
                20.h.hBox,
                AppTextField(
                  controller: controller.amountCntrl,
                  textInputType: TextInputType.number,
                  labelText: "",
                  useHintInsteadOfLabel: true,
                  label: "Total Amount",
                  validator: AppValidators.required,
                ),
                20.h.hBox,
                AppTextField(
                  controller: controller.discountAmountCntrl,
                  textInputType: TextInputType.number,
                  labelText: "",
                  useHintInsteadOfLabel: true,
                  label: "Discount Amount",
                  validator: AppValidators.required,
                ),
                20.h.hBox,
                Text(
                  "Payment Option",
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                5.h.hBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      paymentOption('Cash', controller),
                      paymentOption('Card', controller),
                      paymentOption('UPI', controller),
                    ],
                  ),
                ),
                13.h.hBox,
                AppTextField(
                  controller: controller.advanceAmountCntrl,
                  textInputType: TextInputType.number,
                  labelText: "",
                  useHintInsteadOfLabel: true,
                  label: "Advance Amount",
                  validator: AppValidators.required,
                ),
                20.h.hBox,
                AppTextField(
                  controller: controller.balanceAmountCntrl,
                  textInputType: TextInputType.number,
                  labelText: "",
                  useHintInsteadOfLabel: true,
                  label: "Balance Amount",
                  validator: AppValidators.required,
                ),
                20.h.hBox,
                AppTextField(
                  controller: controller.teatmentDateCntrl,
                  textInputType: TextInputType.visiblePassword,
                  labelText: "",
                  useHintInsteadOfLabel: true,
                  label: "Treatment Date",
                  readOnly: true,
                  validator: AppValidators.required,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: primaryColor,
                      size: 23,
                    ),
                    onPressed: () => controller.pickDob(context),
                  ),
                ),
                20.h.hBox,
                Text(
                  "Treatment Time",
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                15.h.hBox,
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => CustomDropdown<String>(
                          selectedValue: controller.selectedHour.value,
                          items: hours12,
                          w: double.infinity,
                          hint: "Hour",

                          isSelectedValid: true,
                          validator: AppValidators.required,
                          onChanged: (val) =>
                              controller.selectedHour.value = val,
                        ),
                      ),
                    ),
                    10.w.wBox,
                    Expanded(
                      child: Obx(
                        () => CustomDropdown<String>(
                          selectedValue: controller.selectedMinute.value,
                          items: minutes,
                          w: double.infinity,
                          hint: "Minutes",

                          isSelectedValid: true,
                          validator: AppValidators.required,
                          onChanged: (val) =>
                              controller.selectedMinute.value = val,
                        ),
                      ),
                    ),
                    10.w.wBox,
                    Expanded(
                      child: Obx(
                        () => CustomDropdown<String>(
                          selectedValue: controller.selectedAmPm.value,
                          items: amPm,
                          w: double.infinity,
                          hint: "AM/PM",

                          isSelectedValid: true,
                          validator: AppValidators.required,
                          onChanged: (val) =>
                              controller.selectedAmPm.value = val,
                        ),
                      ),
                    ),
                  ],
                ),

                50.h.hBox,
                Obx(()=>
                  AppButton(
                    label: "Save",
                    isLoaderBtn: controller.isLoading.value,
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.registrationSave(context: context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget paymentOption(String title, RegistrationController controller) {
  return Row(
    children: [
      Radio<String>(
        activeColor: primaryColor,
        value: title,
        groupValue: controller.selectedPayment.value,
        onChanged: (value) {
          controller.selectPayment(value!);
        },
      ),
      Text(title),
    ],
  );
}
