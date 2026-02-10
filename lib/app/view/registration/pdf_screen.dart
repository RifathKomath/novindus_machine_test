import 'package:flutter/material.dart';
import 'package:novindus_machine_test/core/style/app_text_style.dart';
import 'package:novindus_machine_test/core/style/colors.dart';
import 'package:printing/printing.dart';
import 'widgets/invoice.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Invoice Preview',style: AppTextStyles.textStyle_600_14,),backgroundColor: whiteClr,),
      body: PdfPreview(
        build: (format) => RegistrationInvoicePdf.generate(),
      ),
    );
  }
}
