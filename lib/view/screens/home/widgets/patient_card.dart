import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_test/model/models.dart';
import 'package:noviindus_test/services/services.dart';

import '../../../../utils/utils.dart';

class PatientCardWidget extends StatelessWidget {
  final int index;
  final PatientModel patient;
  const PatientCardWidget({
    super.key,
    required this.index,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        InvoiceModel invoice = InvoiceModel(patient: patient);
        final pdfFile = await PdfInvoiceServices.generate(invoice);
        log('card clicked');
        log(pdfFile.toString());
        await PdfServices.openFile(pdfFile);
      },
      child: Card(
        color: AppColor.textfieldColor,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: size.height * 0.12,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: size.width * 0.14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.name != null ? '${patient.name}' : 'No Name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          (patient.patientdetailsSet!.isEmpty ||
                                  patient.patientdetailsSet == null)
                              ? 'Name Not Available'
                              : patient.patientdetailsSet![0].treatmentName !=
                                      null
                                  ? patient.patientdetailsSet!.length == 1
                                      ? '${patient.patientdetailsSet![0].treatmentName}'
                                      : '${patient.patientdetailsSet![0].treatmentName} & ${patient.patientdetailsSet!.length - 1}More'
                                  : 'Name Not Available',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppColor.baseColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  patient.dateNdTime != null
                                      ? formatDateString(patient.dateNdTime!)
                                      : 'Date not found',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: size.height * 0.02,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.people_outline,
                                    size: 24,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    patient.user != null
                                        ? '${patient.user}'
                                        : "No Name",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.13,
                ),
                const Text(
                  'View Booking details',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColor.baseColor,
                  size: 35,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDateString(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);
    return formattedDate;
  }
}
