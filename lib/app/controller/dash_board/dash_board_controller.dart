import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novindus_machine_test/core/service/api.dart';
import 'package:novindus_machine_test/core/style/colors.dart';
import 'package:novindus_machine_test/shared/widgets/app_toast.dart';
import '../../../core/service/urls.dart';
import '../../model/dash_board/patient_get_response.dart';

class DashBoardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPatientList();
  }

  RxBool isLoading = false.obs;

  final TextEditingController searchCntrl = TextEditingController();

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  String get formattedDate {
    if (selectedDate.value == null) return "Date";
    return DateFormat('dd MMM yyyy').format(selectedDate.value!);
  }

 Future<void> pickDate(BuildContext context) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: selectedDate.value ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
     builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: whiteClr,
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

  if (date != null) {
    selectedDate.value = date;
    filterPatientsByDate();
  }
}

void filterPatientsByDate() {
  if (selectedDate.value == null) {
    patientList.value = allPatients;
    return;
  }

  patientList.value = allPatients.where((patient) {
    final patientDate = patient.dateNdTime;
    if (patientDate == null) return false;

    return patientDate.year == selectedDate.value!.year &&
           patientDate.month == selectedDate.value!.month &&
           patientDate.day == selectedDate.value!.day;
  }).toList();
}


void clearDate() {
  selectedDate.value = null;
  patientList.value = allPatients;
}

  

  Future<void> refreshBookings() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    getPatientList();

    isLoading.value = false;
  }

  RxList<Patient> patientList = <Patient>[].obs;
  List<Patient> allPatients = [];
  void getPatientList() async {
    try {
      isLoading.value = true;
      final response = await Api.call(endPoint: patientGetUrl);
      if (response.success) {
        final result = GetPatientResponse.fromJson(response.response).patient;
        allPatients = result ?? [];
        patientList.value = result ?? [];
      } else {
        showToast(response.msg);
      }
    } catch (e) {
      print("Error while fetching patient data $e");
    } finally {
      isLoading.value = false;
    }
  }

  void searchByTreatment(String query) {
  if (query.isEmpty) {
    patientList.value = allPatients;
    return;
  }

  final search = query.toLowerCase();

  patientList.value = allPatients.where((patient) {
    final details = patient.patientdetailsSet ?? [];

    return details.any(
      (t) => (t.treatmentName ?? '').toLowerCase().contains(search),
    );
  }).toList();
}

}
