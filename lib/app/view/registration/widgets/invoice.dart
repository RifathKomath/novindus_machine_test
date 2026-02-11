import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../model/dash_board/patient_get_response.dart';

class RegistrationInvoicePdf {
  static Future<Uint8List> generate(Patient patient) async {
    final pdf = pw.Document();
    final svgString = await rootBundle.loadString('assets/images/xl_icon.svg');
    final svgSignature =
        await rootBundle.loadString('assets/images/signature.svg');

    final green = PdfColor.fromHex('#006837');
    final textGrey = PdfColor.fromHex('#9A9A9A');

    final details = patient.patientdetailsSet ?? [];

    final bookedOn = patient.createdAt != null
        ? '${patient.createdAt!.day}/${patient.createdAt!.month}/${patient.createdAt!.year}'
        : '';

    final treatmentDate = patient.dateNdTime != null
        ? '${patient.dateNdTime!.day}/${patient.dateNdTime!.month}/${patient.dateNdTime!.year}'
        : '';

    final treatmentTime = patient.dateNdTime != null
        ? '${patient.dateNdTime!.hour}:${patient.dateNdTime!.minute.toString().padLeft(2, '0')}'
        : '';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (context) {
          return pw.Stack(
            children: [
              pw.Center(
                child: pw.Opacity(
                  opacity: 0.06,
                  child: pw.SvgImage(svg: svgString, width: 300, height: 300),
                ),
              ),

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
              
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SvgImage(svg: svgString, width: 76, height: 80),

                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            patient.branch?.name ?? '',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            patient.branch?.address ??
                                '',
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: textGrey,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'e-mail : ${patient.branch?.mail ?? ''}',
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: textGrey,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'Mob : ${patient.branch?.phone ?? ''}',
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: textGrey,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'GST No : ${patient.branch?.gst ?? ''}',
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ],
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 15),
                  pw.Divider(thickness: 0.7, color: PdfColors.grey400),
                  pw.SizedBox(height: 15),

                  pw.Text(
                    'Patient Details',
                    style: pw.TextStyle(
                      color: green,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                info('Name'),
                                infoValue(patient.name ?? ''),
                              ],
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                info('Address'),
                                infoValue(patient.address ?? ''),
                              ],
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                info('WhatsApp Number'),
                                infoValue(patient.phone ?? ''),
                              ],
                            ),
                          ],
                        ),
                      ),

                      pw.Container(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                info('Booked On'),
                                infoValue(bookedOn),
                              ],
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                info('Treatment Date'),
                                infoValue(treatmentDate),
                              ],
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                info('Treatment Time'),
                                infoValue(treatmentTime),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 20),
                  dottedLine(),
                  pw.SizedBox(height: 12),

                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 6),
                    child: pw.Row(
                      children: [
                        tableHeader('Treatment', flex: 3),
                        tableHeader('Price'),
                        tableHeader('Male'),
                        tableHeader('Female'),
                        tableHeader('Total'),
                      ],
                    ),
                  ),

                  ...details.map(
                    (e) => tableRow(
                      e.treatmentName ?? '',
                      patient.totalAmount?.toString() ?? '0',
                      e.male ?? '0',
                      e.female ?? '0',
                      patient.totalAmount?.toString() ?? '0',
                    ),
                  ),

                  pw.SizedBox(height: 20),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Container(
                        width: 230,
                        padding: const pw.EdgeInsets.all(12),
                        child: pw.Column(
                          children: [
                            amount(
                              'Total Amount',
                              patient.totalAmount?.toString() ?? '0',
                              bold: true,
                            ),
                            amount(
                              'Discount',
                              patient.discountAmount?.toString() ?? '0',
                            ),
                            amount(
                              'Advance',
                              patient.advanceAmount?.toString() ?? '0',
                            ),
                            pw.SizedBox(height: 5),
                            dottedLine(),
                            pw.SizedBox(height: 5),
                            amount(
                              'Balance',
                              patient.balanceAmount?.toString() ?? '0',
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 15),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Container(
                        width: 250,
                        padding: const pw.EdgeInsets.all(12),
                        child: pw.Column(
                          children: [
                            pw.Text(
                              'Thank you for choosing us',
                              style: pw.TextStyle(
                                color: green,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 6),
                            pw.Text(
                              'Your well-being is our commitment, and we are honored to be entrusted with your health journey',
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColor.fromHex('#9A9A9A'),
                              ),
                              textAlign: pw.TextAlign.end,
                            ),
                            pw.SizedBox(height: 26),
                            pw.SvgImage(
                              svg: svgSignature,
                              width: 86,
                              height: 90,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 25),
                  pw.Spacer(),
                  dottedLine(),
                  pw.SizedBox(height: 6),

                  pw.Center(
                    child: pw.Text(
                      '*Booking amount is non-refundable, and it is important to arrive on the allotted time for your treatment*',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColor.fromHex('#9A9A9A'),
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }


  static pw.Widget info(String t) {
    return pw.Container(
      width: 130,
      margin: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Text(
        '$t: ',
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  static pw.Widget infoValue(String v) {
    return pw.Container(
      width: 130,
      margin: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Text(
        v,
        style: pw.TextStyle(
          fontSize: 10,
          color: PdfColor.fromHex('#9A9A9A'),
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget tableHeader(String text, {int flex = 1}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          color: PdfColor.fromHex('#006837'),
        ),
      ),
    );
  }

  static pw.Widget tableRow(
    String t,
    String p,
    String m,
    String f,
    String total,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        children: [
          cell(t, flex: 3),
          cell(p),
          cell(m),
          cell(f),
          cell(total),
        ],
      ),
    );
  }

  static pw.Widget cell(String text, {int flex = 1}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: PdfColor.fromHex('#9A9A9A'),
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget amount(String t, String v, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            t,
            style: pw.TextStyle(fontWeight: bold ? pw.FontWeight.bold : null),
          ),
          pw.Text(
            v,
            style: pw.TextStyle(fontWeight: bold ? pw.FontWeight.bold : null),
          ),
        ],
      ),
    );
  }

  static pw.Widget dottedLine() {
    return pw.LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints!.maxWidth;
        final dashCount = (width / 10).floor();
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount,
            (_) => pw.Container(
              width: 5,
              height: 1,
              color: PdfColors.grey400,
            ),
          ),
        );
      },
    );
  }
}
