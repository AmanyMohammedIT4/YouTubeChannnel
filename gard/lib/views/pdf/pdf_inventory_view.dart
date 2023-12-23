import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class PdfInventoryPreviewPage extends StatelessWidget {
  // List<ItemsModle> invoice;
  List<String> barcodes;
   List<String> productNames;
     String nameInv;
    List<int> count; String date;

  PdfInventoryPreviewPage({Key? key, required this.barcodes,required this.productNames,required this.nameInv,required this.count,required this.date}) : super(key: key);
  final pdf = pw.Document();
  final controller = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(barcodes,productNames,user!,nameInv,count,date),
      ),
    );
  }

  Future<Uint8List> makePdf(List<String> barcodes, List<String> productNames, String email, String nameLoc,List<int> count, String date) async {
   // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
   final font = await rootBundle.load("assets/fonts/IBMPlexSansArabic.ttf");
    final arabicFont = pw.Font.ttf(font);

    pdf.addPage(pw.Page(
      build: (pw.Context context) 
      {
        return pw.Center(
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
                  'التاريخ: $date',
                  style: pw.TextStyle(font: arabicFont, fontSize: 20),
                  textDirection: pw.TextDirection.rtl,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'البريد الإلكتروني: $email',
                  style: pw.TextStyle(font: arabicFont, fontSize: 20),
                  textDirection: pw.TextDirection.rtl,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'الموقع: $nameLoc',
                  style: pw.TextStyle(font: arabicFont, fontSize: 20),
                  textDirection: pw.TextDirection.rtl,
                ),
                pw.SizedBox(height: 20),
                 if (barcodes.isEmpty)
                pw.Text(
                  'لا توجد بيانات متاحة',
                  style: pw.TextStyle(font: arabicFont, fontSize: 20),
                  textDirection: pw.TextDirection.rtl,
                )
              else
                for (var index = 0; index < barcodes.length; index++)
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'الباركود: ${barcodes[index]}',
                        style: pw.TextStyle(font: arabicFont, fontSize: 20),
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.Text(
                        'اسم الصنف: ${productNames[index]}',
                        style: pw.TextStyle(font: arabicFont, fontSize: 20),
                        textDirection: pw.TextDirection.rtl,
                      ),
                       pw.Text(
                        ' الكمية: ${count[index]}',
                        style: pw.TextStyle(font: arabicFont, fontSize: 20),
                        textDirection: pw.TextDirection.rtl,
                      ),
                       ],
                ),
            
              ],
            ),
          
          );
        
      }
    ));
    return pdf.save();
  }
}
