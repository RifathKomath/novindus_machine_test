import 'package:flutter/material.dart';
import 'package:novindus_machine_test/core/style/app_text_style.dart';
import 'package:novindus_machine_test/core/style/colors.dart';
import 'package:printing/printing.dart';
import '../../model/dash_board/patient_get_response.dart';
import 'widgets/invoice.dart';

class PdfPreviewScreen extends StatelessWidget {
  final Patient patient;
  const PdfPreviewScreen({super.key,required this.patient,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Invoice Preview',style: AppTextStyles.textStyle_600_14,),backgroundColor: whiteClr,),
      body: PdfPreview(
        build: (format) => RegistrationInvoicePdf.generate(patient),
      ),
    );
  }
}
