import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class RegistrationInvoicePdf {
  static Future<Uint8List> generate() async {
    final pdf = pw.Document();
    final svgString = await rootBundle.loadString('assets/images/xl_icon.svg');
    final svgSignature = await rootBundle.loadString(
      'assets/images/signature.svg',
    );
    final green = PdfColor.fromHex('#006837');
    final textGrey = PdfColor.fromHex('#9A9A9A');

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
                  /// HEADER
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SvgImage(svg: svgString, width: 76, height: 80),

                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'KUMARAKOM',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'Cheepunkal P.O, Kumarakom, Kottayam, Kerala - 686563',
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: textGrey,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'e-mail : unknown@gmail.com',
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: textGrey,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'Mob : +91 9876543210',
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: textGrey,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'GST No : 32AABCU9603R1ZW',
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
                              children: [_info('Name'), _infoValue('Salin T')],
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _info('Address'),
                                _infoValue('Vadakkave, Kozhikode'),
                              ],
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _info('WhatsApp Number'),
                                _infoValue('+91 987654321'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //second data container
                      pw.Container(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _info('Booked On'),
                                _infoValue('31/01/2024 | 12:12pm'),
                              ],
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _info('Treatment Date'),
                                _infoValue('21/02/2024'),
                              ],
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _info('Treatment Time'),
                                _infoValue('11:00 am'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 20),

                  _dottedLine(),

                  pw.SizedBox(height: 12),

                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 6),
                    child: pw.Row(
                      children: [
                        _tableHeader('Treatment', flex: 3),
                        _tableHeader('Price'),
                        _tableHeader('Male'),
                        _tableHeader('Female'),
                        _tableHeader('Total'),
                      ],
                    ),
                  ),

                  _tableRow('Panchakarma', '230', '4', '4', '2,540'),
                  _tableRow(
                    'Njavara Kizhi Treatment',
                    '230',
                    '4',
                    '4',
                    '2,540',
                  ),
                  _tableRow('Panchakarma', '230', '4', '6', '2,540'),

                  pw.SizedBox(height: 20),

                  /// AMOUNT SUMMARY
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Container(
                        width: 230,
                        padding: const pw.EdgeInsets.all(12),

                        child: pw.Column(
                          children: [
                            _amount('Total Amount', '7,620', bold: true),
                            _amount('Discount', '500'),
                            _amount('Advance', '1,200'),
                            pw.SizedBox(height: 5),
                            _dottedLine(),
                            pw.SizedBox(height: 5),
                            _amount('Balance', '5,920', bold: true),
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
                  _dottedLine(),
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

  /// ---------- HELPERS ----------
  static pw.Widget _info(String t) {
    return pw.Container(
      width: 130,
      margin: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Text(
        '$t: ',
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  static pw.Widget _infoValue(String v) {
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

  static pw.Widget _tableHeader(String text, {int flex = 1}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          color: PdfColor.fromHex('#006837'),
        ),
        textAlign: pw.TextAlign.left,
      ),
    );
  }

  static pw.Widget _tableRow(
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
          _cell(t, flex: 3),
          _cell(p),
          _cell(m),
          _cell(f),
          _cell(total),
        ],
      ),
    );
  }

  static pw.Widget _cell(String text, {int flex = 1}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: PdfColor.fromHex('#9A9A9A'),
          fontWeight: pw.FontWeight.bold,
        ),
        textAlign: pw.TextAlign.left,
      ),
    );
  }

  static pw.Widget _amount(String t, String v, {bool bold = false}) {
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

  static pw.Widget _dottedLine() {
    return pw.LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints?.maxWidth;
        final dashWidth = 5.0;
        final dashCount = (width! / (2 * dashWidth)).floor();

        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return pw.Container(
              width: dashWidth,
              height: 1,
              color: PdfColors.grey400,
            );
          }),
        );
      },
    );
  }
}
