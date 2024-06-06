// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/order_in_model/order_in_model.dart';
import 'package:tzamtzam_hadar/models/order_model/orders_model.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/cards/order_managment_card.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class PrintEnvelope extends StatefulWidget {
  const PrintEnvelope(this.order, {Key? key}) : super(key: key);

  final OrderModel order;

  @override
  State<PrintEnvelope> createState() => _PrintEnvelopeState();
}

class _PrintEnvelopeState extends State<PrintEnvelope> {
  bool showImage = true;
  List<OrderInModel> ifJustOneImage = [];
  bool justOneProduct = false;
  late OrderInModel oneProduct;
  @override
  Widget build(BuildContext context) {
    ifJustOneImage = widget.order.orderInList
        .where((order) => order.category == 'תמונות')
        .toList();
    justOneProduct = widget.order.orderInList.length == 1;
    oneProduct = widget.order.orderInList.first;
    return Scaffold(
      appBar: appAppBar(
          title: appTranslate("print_order",
              arguments: {"num": widget.order.orderId})),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        actions: [
          Switch(
            activeColor: AppColor.primaryColor,
            value: showImage,
            onChanged: (bool value) {
              setState(() {
                showImage = !showImage;
              });
            },
          ),
        ],
        build: (format) => _generatePdf(format, widget.order.orderId),
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
                if (showImage) pw.Image(netImage, fit: pw.BoxFit.fill),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.SizedBox(width: 88),
                        top2Columns(
                            widget.order.customerName,
                            widget.order.date,
                            justOneProduct
                                ? oneProduct.category
                                : appTranslate("many_items"),
                            false,
                            font,
                            fontSize),
                        pw.SizedBox(width: 184),
                        top2Columns("", widget.order.employeeName,
                            widget.order.time, true, font, fontSize),
                      ],
                    ),
                    pw.SizedBox(height: 118),
                    paddingRightText(
                        widget.order.customerName, 120, font, fontSize),
                    pw.SizedBox(height: 20),
                    paddingRightText(
                        widget.order.phoneNumber, 88, font, fontSize),
                    pw.SizedBox(height: 48),
                    paddingRightText(
                        widget.order.date, 88, font, fontSmallSize),
                    pw.SizedBox(height: 76),
                    paddingRightText(
                        GeneralFunctions()
                            .getSumAmount(widget.order.orderInList)
                            .toString(),
                        112,
                        font,
                        fontSmallSize),
                    if (ifJustOneImage.length == 1)
                      if (oneProduct.category == appTranslate("pictures"))
                        pw.Expanded(
                          child: markImagesFillType(font, fontSmallSize),
                        ),
                  ],
                ),
                pw.Positioned(
                  top: 524,
                  right: 104,
                  child: pw.Text(
                    widget.order.employeeName,
                    style: pw.TextStyle(font: font, fontSize: fontSize),
                  ),
                ),
                // if (widget.order.category == appTranslate("pictures"))
                if (ifJustOneImage.length == 1)
                  pw.Positioned(
                    top: getPictureSizeIndex(),
                    left: 190,
                    child: pw.Text(
                      "X",
                      style: pw.TextStyle(font: font, fontSize: fontSmallSize),
                    ),
                  ),
                pw.Positioned(
                  top: 300,
                  left: 52,
                  child: pw.Text(
                    appTranslate("order_num_on_app",
                        arguments: {"num": widget.order.orderId}),
                    style: pw.TextStyle(font: font, fontSize: fontSmallSize),
                  ),
                ),

                notesText(font, fontSmallSize),
                orderTimeText(font, fontSmallSize),
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
      top: 320,
      left: 56,
      child: pw.SizedBox(
        height: 180,
        width: 100,
        child: pw.Text(
          "${getAllOrdersInDetails(widget.order.orderInList)}${widget.order.notes ?? ""}",
          style: pw.TextStyle(
            font: font,
            fontSize: fontSmallSize,
          ),
        ),
      ),
    );
  }

  pw.Positioned orderTimeText(pw.Font font, double fontSmallSize) {
    return pw.Positioned(
      bottom: -50,
      left: 0,
      child: pw.SizedBox(
        height: 120,
        width: 100,
        child: pw.Text(
          widget.order.time,
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
      left: 56,
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
    int index = -1;
    if (oneProduct.photoSize == "אחר") {
      index = 10;
    } else {
      index = globalPicturesSizes
          .indexWhere((element) => element == oneProduct.photoSize);
    }
    return 356 + (index * 17);
  }

  pw.Widget markImagesFillType(pw.Font font, double fontSize) {
    return pw.Row(
      children: [
        pw.Column(
          children: [
            pw.SizedBox(
                height: ifJustOneImage.first.photoType == appTranslate("matte")
                    ? 30
                    : 10),
            paddingRightText("X", 94, font, fontSize),
          ],
        ),
        pw.Column(
          children: [
            pw.SizedBox(
                height:
                    ifJustOneImage.first.photoFill == appTranslate("fit_type")
                        ? 30
                        : 10),
            paddingRightText("X", 44, font, fontSize),
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
        pw.SizedBox(height: leftColumn ? 24 : 4),
        pw.Text(text1, style: pw.TextStyle(font: font, fontSize: fontSize)),
        pw.SizedBox(height: 8),
        pw.Text(text2, style: pw.TextStyle(font: font, fontSize: fontSize)),
        pw.SizedBox(height: 8),
        pw.Text(text3, style: pw.TextStyle(font: font, fontSize: fontSize)),
      ],
    );
  }

  String getAllOrdersInDetails(List<OrderInModel> orderInList) {
    String text = "-----------------------\n";
    for (var element in orderInList) {
      text += getOrderInDetails(element, amount: true, sizeAndFitRow: true);
      text += "\n-----------------------\n";
    }
    return text;
  }
}
