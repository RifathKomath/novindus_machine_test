import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:novindus_machine_test/core/style/colors.dart';

import '../../model/registration/list_model.dart';

class RegistrationController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameCntrl = TextEditingController();
  final TextEditingController whtapNoCntrl = TextEditingController();
  final TextEditingController addressCntrl = TextEditingController();
  final TextEditingController amountCntrl = TextEditingController();
  final TextEditingController discountAmountCntrl = TextEditingController();
  final TextEditingController advanceAmountCntrl = TextEditingController();
  final TextEditingController balanceAmountCntrl = TextEditingController();
  final TextEditingController teatmentDateCntrl = TextEditingController();
  final TextEditingController teatment1Cntrl = TextEditingController();
  final TextEditingController teatment2Cntrl = TextEditingController();

  var selectedPayment = 'Cash'.obs;
  void selectPayment(String value) {
    selectedPayment.value = value;
  }

  Future<void> pickDob(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: primaryColor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      teatmentDateCntrl.text =
          "${pickedDate.day.toString().padLeft(2, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.year}";
    }
  }

  var quantity = 1.obs;

  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  var quantity2 = 1.obs;

  void incrementFemale() {
    quantity2.value++;
  }

  void decrementFemale() {
    if (quantity.value > 1) {
      quantity2.value--;
    }
  }

  RxList<ComboPackage> comboList = <ComboPackage>[].obs;
  void addComboPackage(String title) {
    comboList.add(
      ComboPackage(
        title: title,
        maleCount: quantity.value,
        femaleCount: quantity2.value,
      ),
    );
    quantity.value = 0;
    quantity2.value = 0;
  }

  void removeCombo(int index) {
    comboList.removeAt(index);
  }
}
