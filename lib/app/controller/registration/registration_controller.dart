import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:novindus_machine_test/core/service/api.dart';
import 'package:novindus_machine_test/core/style/colors.dart';
import 'package:novindus_machine_test/shared/widgets/app_toast.dart';
import '../../../core/service/urls.dart';
import '../../../shared/utils/screen_utils.dart';
import '../../../shared/widgets/app_success_dialog.dart';
import '../../model/dash_board/patient_get_response.dart';
import '../../model/registration/get_branch_response.dart';
import '../../model/registration/get_treatment_response.dart';
import '../../model/registration/list_model.dart';
import '../../view/dash_board/dash_board_view.dart';

class RegistrationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getBranch();
    getTreatment();
  }

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
      lastDate: DateTime(2100),
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

  void addComboPackage({ComboPackage? comboToEdit}) {
    final newCombo = ComboPackage(
      id: selectedTreatment.value?.id?.toString(),
      name: selectedTreatment.value?.name,
      maleCount: quantity.value,
      femaleCount: quantity2.value,
    );

    if (comboToEdit != null) {
      final index = comboList.indexWhere((c) => c.id == comboToEdit.id);
      if (index != -1) {
        comboList[index] = newCombo;
      }
    } else {
      comboList.add(newCombo);
    }
    quantity.value = 0;
    quantity2.value = 0;
  }

  void removeCombo(int index) {
    comboList.removeAt(index);
  }

  RxString selectedLocation = "".obs;

  RxList<BranchData> branchList = <BranchData>[].obs;
  RxString selectedBranchId = "".obs;
  Rx<BranchData?> selectedBranch = Rx<BranchData?>(null);

  void getBranch() async {
    try {
      isLoading.value = true;
      final response = await Api.call(endPoint: branchGetUrl);
      if (response.success) {
        final result = GetBranchResponse.fromJson(response.response).branches;
        branchList.value = result ?? [];
      } else {
        showToast(response.msg);
      }
    } catch (e) {
      print("Error while fetching branches $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxList<Treatment> treatmentList = <Treatment>[].obs;
  RxString selectedTreatmentId = "".obs;
  Rx<Treatment?> selectedTreatment = Rx<Treatment?>(null);

  void getTreatment() async {
    try {
      isLoading.value = true;
      final response = await Api.call(endPoint: treatmentGetUrl);
      if (response.success) {
        final result = GetTreatmentResponse.fromJson(
          response.response,
        ).treatments;
        treatmentList.value = result ?? [];
      } else {
        showToast(response.msg);
      }
    } catch (e) {
      print("Error while fetching treatments $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxnString selectedHour = RxnString();
  RxnString selectedMinute = RxnString();
  RxnString selectedAmPm = RxnString();

  Map<String, dynamic> buildPayload() {
    final String treatmentIds = comboList
        .map((combo) => combo.id ?? "")
        .where((id) => id.isNotEmpty)
        .join(",");

    final String maleValue = comboList
        .where((combo) => (combo.maleCount ?? 0) > 0)
        .map((combo) => combo.maleCount.toString())
        .join(",");

    final String femaleValue = comboList
        .where((combo) => (combo.femaleCount ?? 0) > 0)
        .map((combo) => combo.femaleCount.toString())
        .join(",");

    final String dateAndTime =
        "${teatmentDateCntrl.text}-${selectedHour.value}:${selectedMinute.value} ${selectedAmPm.value}";

    return {
      "name": fullNameCntrl.text.trim(),
      "excecutive": "",
      "payment": selectedPayment.value,
      "phone": whtapNoCntrl.text.trim(),
      "address": addressCntrl.text.trim(),
      "total_amount": int.tryParse(amountCntrl.text.trim()) ?? 0,
      "discount_amount": int.tryParse(discountAmountCntrl.text.trim()) ?? 0,
      "advance_amount": int.tryParse(advanceAmountCntrl.text.trim()) ?? 0,
      "balance_amount": int.tryParse(balanceAmountCntrl.text.trim()) ?? 0,
      "date_nd_time": dateAndTime,
      "id": "",
      "male": maleValue,
      "female": femaleValue,
      "branch": selectedBranchId.value,
      "treatments": treatmentIds,
    };
  }

  void registrationSave({required BuildContext context}) async {
    try {
      isLoading.value = true;

      final response = await Api.call(
        endPoint: registrationSaveUrl,
        method: Method.post,
        body: buildPayload(),
        isFormData: true,
      );
      if (response.success) {
        SuccessDialog.show(
          context,
          message: "Registration completed successfully",
          onComplete: () {
            Screen.openClosingCurrent(DashBoardView());
          },
        );
      } else {
        showToast(
          response.msg.isNotEmpty ? response.msg : "Error while saving",
        );
      }
    } catch (e) {
      print("Error while saving $e");
    } finally {
      isLoading.value = false;
    }
  }
}
