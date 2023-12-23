import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class PdfPreviewPage extends StatelessWidget {
  // List<ItemsModle> invoice;
  List<String> barcodes;
   List<String> productNames;
   String nameLoc; String date;

  PdfPreviewPage({Key? key, required this.barcodes,required this.productNames,required this.nameLoc,required this.date}) : super(key: key);
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
        build: (context) => makePdf(barcodes,productNames,user!,nameLoc,date),
      ),
      backgroundColor: Colors.white,
    );
    
  }

  Future<Uint8List> makePdf(List<String> barcodes, List<String> productNames, String email, String nameLoc, String date) async {
   // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
   final font = await rootBundle.load("assets/fonts/IBMPlexSansArabic.ttf");
    final arabicFont = pw.Font.ttf(font);
  final colorHex = rgbToHex(0, 197, 105);

    pdf.addPage(pw.Page(
      pageTheme: pw.PageTheme(
        theme:pw.ThemeData() 
      ),
      // theme:pw.ThemeData(
      //  iconTheme : pw.IconThemeData(color: PdfColor.fromHex(colorHex)),
      //   // accentColor: Colors.green,
      // ),
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
                       ],
                ),
            
              ],
            ),
          
          );
        
      }
      // => 
      // pw.Center(
      //   child: pw.Column(children: [
      //     pw.Row(
      //       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      //       children: [
      //         pw.Column(
      //           children: [
      //             pw.Text("Attention to: "),
      //             pw.Text("invoice.address"),
      //           ],
      //           crossAxisAlignment: pw.CrossAxisAlignment.start,
      //         ),
      //       ],
      //     ),
      //     pw.Table(
      //       border: pw.TableBorder.all(color: PdfColors.black),
      //       children: [
      //         // The first row just contains a phrase 'INVOICE FOR PAYMENT'
      //         pw.TableRow(
      //           children: [
      //             pw.Padding(
      //               child: pw.Text(
      //                 'INVOICE FOR PAYMENT',
      //               ),
      //               padding: pw.EdgeInsets.all(20),
      //             ),
      //           ],
      //         ),
      //         // The remaining rows contain each item from the invoice, and uses the
      //         // map operator (the ...) to include these items in the list
      //         ...barcodes
      //             .map((i) => pw.TableRow(
      //                   children: [
      //                     // We can use an Expanded widget, and use the flex parameter to specify
      //                     // how wide this particular widget should be. With a flex parameter of
      //                     // 2, the description widget will be 66% of the available width.
      //                     pw.Expanded(
      //                       child: pw.Padding(
      //                           padding: pw.EdgeInsets.all(10),
      //                           child: pw.Text(i.!)),
      //                       flex: 2,
      //                     ),
      //                     // Again, with a flex parameter of 1, the cost widget will be 33% of the
      //                     // available width.
      //                     pw.Expanded(
      //                       child: pw.Padding(
      //                           padding: pw.EdgeInsets.all(10),
      //                           child: pw.Text("${i.barcode}")),
      //                       flex: 1,
      //                     )
      //                   ],
      //                 ))
      //             .toList(),
      //         // After the itemized breakdown of costs, show the tax amount for this invoice
      //         // In this case, it's just 10% of the invoice amoun
      //         // Show the total
      //         pw.TableRow(
      //           children: [
      //             pw.Padding(
      //               padding: pw.EdgeInsets.all(10),
      //               child:pw.Text('TOTAL Count')),
      //             pw.Padding(
      //               padding: pw.EdgeInsets.all(10),
      //               child:pw.Text("${items.length}")),
      //           ],
      //         )
      //       ],
      //     ),
      //   ]),
      // ),
    
    ));
    return pdf.save();
  }
}
