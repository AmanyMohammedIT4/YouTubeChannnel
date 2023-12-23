
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/model/query_inventory_model.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class PDFInventoryView extends StatelessWidget {
   final List<QueryInventoryModel> reportData;
 
   String invName;

  PDFInventoryView({ required this.reportData ,required this.invName});

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
        build: (context) => showReport(reportData,user!,invName),
      ),
    );
  }
  
Future<Uint8List> showReport(List<QueryInventoryModel> queryInvnetoryModel, String email,String invName) async {
  final pdf = pw.Document();
  final font = await rootBundle.load("assets/fonts/IBMPlexSansArabic.ttf");
  final arabicFont = pw.Font.ttf(font);
  DateTime date = DateTime.now();

  final int itemsPerPage = 10; // عدد البيانات في كل صفحة
  final int pageCount = (queryInvnetoryModel.length / itemsPerPage).ceil(); // عدد الصفحات

  for (var i = 0; i < pageCount; i++) {
    final int startIndex = i * itemsPerPage;
    final int endIndex = min(startIndex + itemsPerPage, queryInvnetoryModel.length);
    final List<QueryInventoryModel> currentPageData = queryInvnetoryModel.sublist(startIndex, endIndex);

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
                  pw.Text(
                    'الموقع: ${invName}',
                    style: pw.TextStyle(font: arabicFont, fontSize: 22),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(height: 20),
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
                         pw.Text(
                          'الكمية: ${currentPageData[index].count}',
                          style: pw.TextStyle(font: arabicFont, fontSize: 15),
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