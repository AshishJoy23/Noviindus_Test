import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_test/controller/controllers.dart';
import 'package:noviindus_test/model/models.dart';
import 'package:noviindus_test/services/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceServices {
  static Future<File> generate(InvoiceModel invoice) async {
    final pdf = pw.Document();
    Uint8List bytesList = await loadAssetImage();
    // pdf.addPage(pw.Page(build: (context) {
    //   return pw.Text('Hello World');
    // },));

    pdf.addPage(pw.MultiPage(
      build: (context) => [
        buildHeader(invoice, bytesList),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        buildInvoice(invoice),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        pw.Divider(color: PdfColors.grey, thickness: 1),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        buildTotal(invoice),
        pw.SizedBox(height: 2 * PdfPageFormat.cm),
        buildThanksMessage()
      ],
      footer: (context) => buildFooter(),
    ));
    var pdfFile = await PdfServices.saveDocument(
        name: '${invoice.patient.name}_${invoice.patient.id}.pdf', pdf: pdf);
    return pdfFile;
  }

  static pw.Widget buildHeader(InvoiceModel invoice, Uint8List bytesList) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              height: 3 * PdfPageFormat.cm,
              width: 3 * PdfPageFormat.cm,
              child: pw.Image(
                pw.MemoryImage(
                  bytesList,
                ),
              ),
            ),
            buildBranchAddress(invoice.patient.branch),
          ],
        ),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        pw.Divider(color: PdfColors.grey, thickness: 1),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        pw.Text('Patient Details',
            style: pw.TextStyle(
                font: pw.Font.helveticaBold(), color: PdfColors.green400)),
        pw.SizedBox(height: 1 * PdfPageFormat.mm),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            buildPatientDetails(invoice.patient),
            buildTreatmentInfo(invoice.patient),
          ],
        ),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        pw.Divider(color: PdfColors.grey, thickness: 1),
      ],
    );
  }

  static Future<Uint8List> loadAssetImage() async {
    final ByteData data = await rootBundle.load('assets/icon1.png');
    final Uint8List bytes = data.buffer.asUint8List();
    return bytes;
  }

  static pw.Widget buildBranchAddress(BranchModel? branch) => branch != null
      ? pw.Expanded(
          child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(branch.name!,
                style: pw.TextStyle(font: pw.Font.helveticaBold())),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text('${branch.location!}, ${branch.address!}',
                style: const pw.TextStyle(color: PdfColors.grey)),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text('e-mail: ${branch.mail}',
                style: const pw.TextStyle(color: PdfColors.grey)),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text('Mob: ${branch.phone!}',
                style: const pw.TextStyle(color: PdfColors.grey)),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text('GST No: ${branch.gst!}',
                style: pw.TextStyle(font: pw.Font.helveticaBold())),
          ],
        ))
      : pw.Expanded(
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
              pw.Text('Branch Details Not Available',
                  style: const pw.TextStyle(color: PdfColors.grey)),
            ]));

  static pw.Widget buildTreatmentInfo(PatientModel patient) => pw.Expanded(
      flex: 5,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Expanded(
                  flex: 4,
                  child: pw.Text('Booked On',
                      style: pw.TextStyle(font: pw.Font.helveticaBold()))),
              pw.Expanded(
                flex: 6,
                child: pw.Text(
                    '${formatDate(patient.createdAt!)} | ${formatTime(patient.createdAt!)}',
                    style: const pw.TextStyle(color: PdfColors.grey)),
              ),
            ],
          ),
          pw.SizedBox(height: 1 * PdfPageFormat.mm),
          pw.Row(
            children: [
              pw.Expanded(
                  flex: 4,
                  child: pw.Text('Treatment Date',
                      style: pw.TextStyle(font: pw.Font.helveticaBold()))),
              pw.Expanded(
                flex: 6,
                child: pw.Text(
                    patient.dateNdTime != null
                        ? formatDate(patient.dateNdTime!)
                        : 'Not Available',
                    style: const pw.TextStyle(color: PdfColors.grey)),
              ),
            ],
          ),
          pw.SizedBox(height: 1 * PdfPageFormat.mm),
          pw.Row(
            children: [
              pw.Expanded(
                  flex: 4,
                  child: pw.Text('Treatment Time',
                      style: pw.TextStyle(font: pw.Font.helveticaBold()))),
              pw.Expanded(
                flex: 6,
                child: pw.Text(
                    patient.dateNdTime != null
                        ? formatTime(patient.dateNdTime!)
                        : 'Not Available',
                    style: const pw.TextStyle(color: PdfColors.grey)),
              ),
            ],
          ),
        ],
      ));

  static String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  }

  static String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return formattedTime;
  }

  static pw.Widget buildPatientDetails(PatientModel patient) => pw.Expanded(
      flex: 5,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Expanded(
                  flex: 5,
                  child: pw.Text('Name',
                      style: pw.TextStyle(font: pw.Font.helveticaBold()))),
              pw.Expanded(
                flex: 5,
                child: pw.Text(patient.name ?? 'Not Available',
                    style: const pw.TextStyle(color: PdfColors.grey)),
              ),
            ],
          ),
          pw.SizedBox(height: 1 * PdfPageFormat.mm),
          pw.Row(
            children: [
              pw.Expanded(
                  flex: 5,
                  child: pw.Text('Address',
                      style: pw.TextStyle(font: pw.Font.helveticaBold()))),
              pw.Expanded(
                flex: 5,
                child: pw.Text(patient.address ?? 'Not Available',
                    style: const pw.TextStyle(color: PdfColors.grey)),
              ),
            ],
          ),
          pw.SizedBox(height: 1 * PdfPageFormat.mm),
          pw.Row(
            children: [
              pw.Expanded(
                  flex: 5,
                  child: pw.Text('Whatapp Number',
                      style: pw.TextStyle(font: pw.Font.helveticaBold()))),
              pw.Expanded(
                flex: 5,
                child: pw.Text(patient.phone ?? 'Not Available',
                    style: const pw.TextStyle(color: PdfColors.grey)),
              ),
            ],
          ),
        ],
      ));

  static pw.Widget buildInvoice(InvoiceModel invoice) {
    final TreatmentController tController = Get.put(TreatmentController());
    final headers = [
      'Treatment',
      'Price',
      'Male',
      'Female',
      'Total',
    ];
    final data = invoice.patient.patientdetailsSet!.map((item) {
      var treatmentName = pw.Text('Not Available');
      var price = '0';
      var male = '0';
      var female = '0';
      var total = '0';
      if (item.treatment != null) {
        final treatment = tController.treatmentsList
            .firstWhere((element) => element.id == item.treatment);
        treatmentName = pw.Text(item.treatmentName!,overflow: pw.TextOverflow.clip);
        price = treatment.price!;
        male = item.male!;
        female = item.female!;
        total = '${int.parse(price) * (int.parse(male) + int.parse(female))}';
      }

      return [
        treatmentName,
        price,
        male,
        female,
        total,
      ];
    }).toList();
    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: pw.TextStyle(
          font: pw.Font.helveticaBold(), color: PdfColors.green400),
      cellHeight: 25,
      cellStyle: const pw.TextStyle(),
      columnWidths: {
        0: const pw.FractionColumnWidth(0.5),
        1: const pw.FractionColumnWidth(0.125),
        2: const pw.FractionColumnWidth(0.125),
        3: const pw.FractionColumnWidth(0.125),
        4: const pw.FractionColumnWidth(0.125),
      },
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
    );
  }

  static pw.Widget buildTotal(InvoiceModel invoice) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 6),
          pw.Expanded(
            flex: 4,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('Total Amount',
                        style: pw.TextStyle(font: pw.Font.helveticaBold())),
                    pw.Spacer(),
                    pw.Text('${invoice.patient.totalAmount}',
                        style: pw.TextStyle(font: pw.Font.helveticaBold())),
                  ],
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                pw.Row(
                  children: [
                    pw.Text('Discount'),
                    pw.Spacer(),
                    pw.Text('${invoice.patient.discountAmount}'),
                  ],
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                pw.Row(
                  children: [
                    pw.Text('Advance'),
                    pw.Spacer(),
                    pw.Text('${invoice.patient.advanceAmount}'),
                  ],
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                pw.Divider(color: PdfColors.grey, thickness: 1),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                pw.Row(
                  children: [
                    pw.Text('Balance',
                        style: pw.TextStyle(font: pw.Font.helveticaBold())),
                    pw.Spacer(),
                    pw.Text('${invoice.patient.balanceAmount}',
                        style: pw.TextStyle(font: pw.Font.helveticaBold())),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget buildThanksMessage() {
    var title = 'Thank you for choosing us';
    var message =
        "Your well-being is our commitment, and we're honored\nyou've entrusted us with your health journey";
    return pw.Row(
      children: [
        pw.Spacer(),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(title,
                style: pw.TextStyle(
                    font: pw.Font.helveticaBold(), color: PdfColors.green400)),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Text(message,
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(
                  color: PdfColors.grey,
                  fontSize: 10,
                )),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
          ],
        )
      ],
    );
  }

  static pw.Widget buildFooter() {
    var footer =
        "Booking amount is non-refundable, and it's important to arrive on the allotted time for your treatment";
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Divider(color: PdfColors.grey, thickness: 1),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        pw.Text(footer,
            style: const pw.TextStyle(
              color: PdfColors.grey,
              fontSize: 10,
            )),
      ],
    );
  }
}
