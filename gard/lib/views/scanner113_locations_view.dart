
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/scan_view_model.dart';
import 'package:gard/views/widgets/bar_widget.dart';
import 'package:gard/views/widgets/buttons.dart';
import 'package:gard/views/widgets/custom_Text.dart';
import 'package:gard/views/widgets/title_widget.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ScannerLocationsView extends StatelessWidget {

  final String? nameLoc;
    ScannerLocationsView({  this.nameLoc,  });

 final controller = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    final searchTextController =TextEditingController();
    String manualBarcode='' ;
    DateTime date = DateTime.now();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final user = controller.user;

//    Future syncToMysql() async {
//     await ScanViewModel()
//         .scanLocationDatabaseHelper
//         .retrieveDataFromSqlite()
//         .then((userList) async {
//       EasyLoading.show(status: 'Dont close app. we are sync...');
//       await ScanViewModel().saveToFirestoreRefresh(userList);
//       EasyLoading.showSuccess('Successfully save to mysql');
//     });
// }
    Future syncToMysql() async {
  EasyLoading.show(status: 'Dont close app. we are sync...');

  // استرجع البيانات من قاعدة البيانات
  List<Map<String, dynamic>> userList =
      await ScanViewModel().scanLocationDatabaseHelper.retrieveDataFromSqlite();

  // قم بفتح قاعدة البيانات هنا
  Database database = await ScanViewModel().scanLocationDatabaseHelper.initDb();
   await database.isOpen;

  // قم بحفظ البيانات في قاعدة البيانات الخارجية (مثل MySQL)
  await ScanViewModel().saveToFirestoreRefresh(userList);

  // أغلق قاعدة البيانات
  // await database.close();
  
  EasyLoading.showSuccess('Successfully save to mysql');
}
    
    return GetBuilder<ScanViewModel>(
          init: Get.find<ScanViewModel>(),
          builder:(controller)=>Scaffold(
            appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TitleWidget(name:'$user',),
          ),
           
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Container(
                height: 55,
                margin: const EdgeInsets.all(10),
                child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(onPressed: ()async{
                         try{
                     for(int i=0;i<controller.barcodeList.length;i++){
                       String barcodeValue = controller.barcodeList[i];
                          String nameProductValue = controller.productNameList[i];

                        if( await ScanViewModel.isInternet() == true){
                     controller.addToFirestore(
                            user!,nameLoc!,barcodeValue,nameProductValue,date);
                            print('controller.barcodeList[i]:${controller.barcodeList[i]} and\n controller.barcodeList.length : ${controller.barcodeList.length} ');

                          
                      //   final pdfViewerController = Get.put(PDFViewerController(file: File('report.pdf')));
                      // pdfViewerController.createAndDisplayPDF(controller.barcodeList, 
                      // controller.productNameList, email!, nameLoc!, date.toString()
                      // );
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('تم الترحيل بنجاح'),
                        ));
                    
                    } else{
                     await   controller.scanLocationDatabaseHelper.insertData(nameProductValue, barcodeValue,
                        user!, nameLoc!, date.toIso8601String());
                        
                     print('insert into tableScanLocation in sqlflite : \n');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('لم يتم ترحيل البيانات بنجاح الرجاء عمل تحديث عند الاتصال بالانترنت لترحيل البيانات'),
                          ));
                        }}
                      // مسح البيانات المرتبطة بعملية الترحيل
                       controller.clearBarcodeList();
                       
                     

                   } on FirebaseAuthException catch (e) {
                        print('حدث خطأ أثناء الارسال: ${e.code} - ${e.message}');
                        }
                    
                      }, text:'ترحيل',sizeBorder: 5,width: 130,),
                      
                      // CustomButton(
                      // onPressed: () {
                      //   Get.to(() => PdfPreviewPage(barcodes: controller.barcodeList, 
                      //   productNames: controller.productNameList, nameLoc: nameLoc!, date: date.toString(),));
                      //     }, text:'عرض التقارير',sizeBorder: 5,width: 130)
                            ],
                          )     
        ),
          body:  Column(
              children: [
                barWidget(
                  text: nameLoc!,
                  onTap: () {
                          Get.back();
                        },),
               Row(
                children: [
                   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextFormField(
                      readOnly: false,
                       key: _formKey,
                      controller: searchTextController,
                      onChanged: (value) {
                        manualBarcode = value;
                      },
                      onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            // إضافة الباركود إلى الجدول
                            controller.addToBarcodeList(value);
                            // إعادة رسم الواجهة
                            Get.forceAppUpdate();
                          }
                        },
                      decoration: InputDecoration(
                        labelText: 'رقم الصنف',
                        border: InputBorder.none,
                      ),
                    ),
                    ),
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){
                        controller.scanBarcodeNormal();
                        // controller.getProduct(manualBarcode);
                      },
                      child: Icon(Icons.camera_alt_rounded,size: 40,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: ()async{
                        await ScanViewModel.isInternet().then((connection){
                          if(connection){
                             syncToMysql();
                            //   final pdfViewerController = Get.put(PDFViewerController(file: File('report.pdf')));
                            //   pdfViewerController.createAndDisplayPDF(controller.barcodeList, 
                            //   controller.productNameList, email!, nameLoc!, date.toString()
                            // );
                            print("Internet connection abailale");
                          }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("لايوجد انترنت!")));
                              }
                        });
                      },
                      child: Icon(Icons.refresh_outlined,size: 30,)),
                  ),
                ],
               ),
                 Expanded(
                child: Obx(() =>  controller.barcodeList.length==0 
                      ? Center(
                        child: CustomText(
                          text: 'افتح الكاميرا',
                        ),
                      )
                      : 
                ListView.builder(
                  itemCount: controller.barcodeList.length+1,
                  itemBuilder: (context, index) {
                    if(index==0){
                  // إنشاء صف الأعمدة
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Table(
                         border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: TbarColor,
                            ),
                            children: [
                              Container(
                                height: 50,
                                child: Center(
                                  child: TableCell(
                                    child: Text('الباركود'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                child: Center(
                                  child: TableCell(
                                    child: Text('اسم الصنف'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                
                    }else{
                      final dataIndex = index - 1;
                      return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        Container(
                          child: Center(
                            child: TableCell(
                              child: CustomText(
                                text:  manualBarcode.isNotEmpty
                                      ? manualBarcode
                                      : controller.barcodeList[dataIndex],
                                fontSize: 20,),
                            ),
                          ),
                        ),
                 Container(
                    child: Center(
                      child: TableCell(
                        child: Obx(() {
                          if (controller.productNameList.isNotEmpty && dataIndex < controller.productNameList.length) {
                            return CustomText(
                              text: controller.productNameList[dataIndex],
                              fontSize: 20,
                            );
                          } else {
                            return CustomText(
                              text: '',
                              fontSize: 20,
                            );
                          }
                        }),
                      ),
                    ),
                  ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            }
            },
          )),
          ),  
      ],),
      ),
          
         
         
    );
  }
}
