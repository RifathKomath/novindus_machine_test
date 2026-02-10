import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashBoardController extends GetxController{
  RxBool isLoading = false.obs;


  final TextEditingController searchCntrl = TextEditingController();

   Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  String get formattedDate {
    if (selectedDate.value == null) return "Date";
    return DateFormat('dd MMM yyyy').format(selectedDate.value!);
  }

  Future<void> pickDate(context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate:DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      selectedDate.value = date;
    }
  }

  void clearDate() {
    selectedDate.value = null;
  }


  Future<void> refreshBookings() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    // fetchBookings();

    isLoading.value = false;
  }

}