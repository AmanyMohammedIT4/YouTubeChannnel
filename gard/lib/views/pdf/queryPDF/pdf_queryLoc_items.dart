
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/model/query_location_model.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFLocItemsView extends StatelessWidget {
  PDFLocItemsView({required this.reportDataLoc,required this.namePro});

  final List<QueryLocationModel> reportDataLoc;
  final String namePro;

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
        build: (context) => showReport(reportDataLoc,user!,namePro),
      ),
    );
  }
  
Future<Uint8List> showReport(List<QueryLocationModel> reportLocData,String email,String namePro) async {
  final pdf = pw.Document();
  final font = await rootBundle.load("assets/fonts/IBMPlexSansArabic.ttf");
  final arabicFont = pw.Font.ttf(font);
  DateTime date = DateTime.now();

  final int itemsPerPage = 10; // عدد البيانات في كل صفحة
  final int pageCountLoc = (reportLocData.length / itemsPerPage).ceil(); 
  for (var i = 0; i <  pageCountLoc; i++) {
    final int startIndex = i * itemsPerPage;
    final int endIndexLoc = min(startIndex + itemsPerPage, reportLocData.length);
     final List<QueryLocationModel> currentPageDataLoc = reportLocData.sublist(startIndex,endIndexLoc);

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
                    'اسم الصنف: ${namePro}',
                    style: pw.TextStyle(font: arabicFont, fontSize: 22),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(height: 20),
                   if (currentPageDataLoc.isEmpty)
                pw.Text(
                  'لا توجد بيانات متاحة',
                  style: pw.TextStyle(font: arabicFont, fontSize: 20),
                  textDirection: pw.TextDirection.rtl,
                )
              else
                   for (var index = 0; index < currentPageDataLoc.length; index++)
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
                         'الباركود: ${currentPageDataLoc[index].barcode}',
                         style: pw.TextStyle(font: arabicFont, fontSize: 20),
                         textDirection: pw.TextDirection.rtl,
                       ),
                         pw.Text(
                        ' الموقع: ${currentPageDataLoc[index].locName}',
                        style: pw.TextStyle(font: arabicFont, fontSize: 20),
                        textDirection: pw.TextDirection.rtl,
                         ),
                       ],
                     ),),
                          ],) ),
                 
              );
        }
          ));
        }
         return pdf.save();
  }
}
 
