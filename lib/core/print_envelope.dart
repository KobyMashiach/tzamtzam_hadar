// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class PrintEnvelope extends StatelessWidget {
  const PrintEnvelope(this.order, {Key? key}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(
          title:
              appTranslate("print_order", arguments: {"num": order.orderId})),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        onPrinted: (context) {},
        build: (format) => _generatePdf(format, order.orderId),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.secularOneRegular();
    final double fontSize = 12;
    final double fontSmallSize = 8;
    final netImage =
        await networkImage('https://i.postimg.cc/RVVcwXcS/yellow-envelope.jpg');
    // final netImage =
    //     await networkImage('https://i.postimg.cc/KjbczsqB/image.jpg');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        textDirection: pw.TextDirection.rtl,
        orientation: pw.PageOrientation.portrait,
        build: (context) {
          return pw.FullPage(
            ignoreMargins: true,
            child: pw.Stack(
              children: [
                pw.Image(netImage, fit: pw.BoxFit.fill),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.SizedBox(width: 80),
                        top2Columns(order.customerName, order.date,
                            order.category, false, font, fontSize),
                        pw.SizedBox(width: 200),
                        top2Columns("", order.employeeName!, order.time, true,
                            font, fontSize),
                      ],
                    ),
                    pw.SizedBox(height: 118),
                    paddingRightText(order.customerName, 120, font, fontSize),
                    pw.SizedBox(height: 12),
                    paddingRightText(order.phoneNumber, 88, font, fontSize),
                    pw.SizedBox(height: 40),
                    paddingRightText(order.date, 84, font, fontSmallSize),
                    pw.SizedBox(height: 69),
                    paddingRightText(
                        order.amount.toString(), 108, font, fontSmallSize),
                    // canvas , pictures, sublimation, general
                    if (order.category == appTranslate("pictures"))
                      pw.Expanded(
                        child: markImagesFillType(font, fontSmallSize),
                      ),
                  ],
                ),
                pw.Positioned(
                  top: 500,
                  right: 100,
                  child: pw.Text(
                    order.employeeName!,
                    style: pw.TextStyle(font: font, fontSize: fontSize),
                  ),
                ),
                if (order.category == appTranslate("pictures"))
                  pw.Positioned(
                    top: getPictureSizeIndex(),
                    left: 204,
                    child: pw.Text(
                      "X",
                      style: pw.TextStyle(font: font, fontSize: fontSmallSize),
                    ),
                  ),
                pw.Positioned(
                  top: 324,
                  left: 60,
                  child: pw.Text(
                    appTranslate("order_num_on_app",
                        arguments: {"num": order.orderId}),
                    style: pw.TextStyle(font: font, fontSize: fontSmallSize),
                  ),
                ),
                if (order.notes != null && order.notes != "")
                  notesText(font, fontSmallSize),
                if (order.category == appTranslate("canvas"))
                  buttonText(
                      "${appTranslate("canvas")} ${appTranslate("in_size")} ${order.canvasSize}",
                      font,
                      fontSmallSize),
                if (order.category == appTranslate("sublimation"))
                  buttonText(order.sublimationProduct!, font, fontSmallSize),
              ],
            ),
          );
        },
      ),
    );
//TODO: order_num_on_app
    return pdf.save();
  }

  pw.Positioned notesText(pw.Font font, double fontSmallSize) {
    return pw.Positioned(
      top: 342,
      left: 60,
      child: pw.SizedBox(
        height: 120,
        width: 100,
        child: pw.Text(
          order.notes!,
          style: pw.TextStyle(
            font: font,
            fontSize: fontSmallSize,
          ),
        ),
      ),
    );
  }

  pw.Positioned buttonText(String text, pw.Font font, double fontSmallSize) {
    return pw.Positioned(
      top: 500,
      left: 60,
      child: pw.SizedBox(
        height: 120,
        width: 100,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            font: font,
            fontSize: fontSmallSize,
          ),
        ),
      ),
    );
  }

  double getPictureSizeIndex() {
    final int index =
        globalPicturesSizes.indexWhere((element) => element == order.photoSize);
    return 346 + (index * 16);
  }

  pw.Widget markImagesFillType(pw.Font font, double fontSize) {
    return pw.Row(
      children: [
        pw.Column(
          children: [
            pw.SizedBox(
                height: order.photoType == appTranslate("matte") ? 27 : 7),
            paddingRightText("X", 90, font, fontSize),
          ],
        ),
        pw.Column(
          children: [
            pw.SizedBox(
                height: order.photoFill == appTranslate("fit_type") ? 27 : 7),
            paddingRightText("X", 40, font, fontSize),
          ],
        ),
      ],
    );
  }

  pw.Widget paddingRightText(
      String text, double padding, pw.Font font, double fontSize) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(right: padding),
      child: pw.Text(
        text,
        style: pw.TextStyle(font: font, fontSize: fontSize),
      ),
    );
  }

  pw.Column top2Columns(String text1, String text2, String text3,
      bool leftColumn, pw.Font font, double fontSize) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.SizedBox(height: leftColumn ? 32 : 15),
        pw.Text(text1, style: pw.TextStyle(font: font, fontSize: fontSize)),
        pw.SizedBox(height: 8),
        pw.Text(text2, style: pw.TextStyle(font: font, fontSize: fontSize)),
        pw.SizedBox(height: 8),
        pw.Text(text3, style: pw.TextStyle(font: font, fontSize: fontSize)),
      ],
    );
  }
}
