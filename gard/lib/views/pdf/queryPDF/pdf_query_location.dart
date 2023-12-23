
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/model/items_model.dart';
import 'package:gard/model/query_location_model.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class PDFLocationView extends StatelessWidget {
   final List<QueryLocationModel> reportData;
 
String locName;
  PDFLocationView({ required this.reportData ,required this.locName});

  final pdf = pw.Document();
  final controller = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض التقرير'),
      ),
      body: PdfPreview(
        build: (context) => showReport(reportData,user!,locName),
      ),
    );
  }
  
Future<Uint8List> showReport(List<QueryLocationModel> queryLocationModel, String email,String locName) async {
  final pdf = pw.Document();
  final font = await rootBundle.load("assets/fonts/IBMPlexSansArabic.ttf");
  final arabicFont = pw.Font.ttf(font);
  DateTime date = DateTime.now();

  final int itemsPerPage = 10; // عدد البيانات في كل صفحة
  final int pageCount = (queryLocationModel.length / itemsPerPage).ceil(); // عدد الصفحات

  for (var i = 0; i < pageCount; i++) {
    final int startIndex = i * itemsPerPage;
    final int endIndex = min(startIndex + itemsPerPage, queryLocationModel.length);
    final List<QueryLocationModel> currentPageData = queryLocationModel.sublist(startIndex, endIndex);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 10,
          marginLeft: 10,
          marginRight: 10,
          marginTop: 10,
        ),
        theme: pw.ThemeData().copyWith(
          defaultTextStyle: pw.TextStyle(font: arabicFont, fontSize: 20),
        ),
        build: (pw.Context context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(10),
            child: pw.Center(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(child: pw.Text(
                    'التقرير ',
                    style: pw.TextStyle(font: arabicFont, fontSize: 40, fontWeight: pw.FontWeight.bold),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'اسم المستخدم : ${email}',
                    style: pw.TextStyle(font: arabicFont, fontSize: 30, fontWeight: pw.FontWeight.bold),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'تاريخ اليوم : ${date}',
                    style: pw.TextStyle(font: arabicFont, fontSize: 30, fontWeight: pw.FontWeight.bold),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(height: 20),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'الموقع: ${locName}',
                    style: pw.TextStyle(font: arabicFont, fontSize: 22),
                    textDirection: pw.TextDirection.rtl,
                  ),
                   if (currentPageData.isEmpty)
                pw.Text(
                  'لا توجد بيانات متاحة',
                  style: pw.TextStyle(font: arabicFont, fontSize: 20),
                  textDirection: pw.TextDirection.rtl,
                )
              else
                  for (var index = 0; index < currentPageData.length; index++)
                   pw.Container(
                          margin: pw.EdgeInsets.all(10),
                          decoration:pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                              width: 2.0
                            )
                          ),
                          child:  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                        'الباركود: ${currentPageData[index].barcode}',
                        style: pw.TextStyle(font: arabicFont, fontSize: 20),
                        textDirection: pw.TextDirection.rtl,
                                                ),
                        pw.Text(
                          'اسم الصنف: ${currentPageData[index].namePro}',
                          style: pw.TextStyle(font: arabicFont, fontSize: 20),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ],
                    ),
               
                           ),
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  return pdf.save();
}
 
}