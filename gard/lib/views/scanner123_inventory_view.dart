import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/scan_Inventory_view_model.dart';
import 'package:gard/views/widgets/bar_widget.dart';
import 'package:gard/views/widgets/buttons.dart';
import 'package:gard/views/widgets/custom_Text.dart';
import 'package:gard/views/widgets/title_widget.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ScannerInventoryView extends StatelessWidget {

  final String? nameInv;
  ScannerInventoryView({  this.nameInv, });

  
   final List<bool> isQuantityValidList = [];
   
final controller = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    final user =controller.user;

    final searchTextController =TextEditingController();
    String manualBarcode='' ;
    DateTime date = DateTime.now();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 Future syncToMysql() async {
  EasyLoading.show(status: 'Dont close app. we are sync...');

  // استرجع البيانات من قاعدة البيانات
  List<Map<String, dynamic>> userList =
      await ScanInventoryViewModel().scanInventoryDatabaseHelper.retrieveDataFromSqlite();

  // قم بفتح قاعدة البيانات هنا
  Database database = await ScanInventoryViewModel().scanInventoryDatabaseHelper.initDb();
  
  // قم بحفظ البيانات في قاعدة البيانات الخارجية (مثل MySQL)
  await ScanInventoryViewModel().saveToFirestoreRefresh(userList);

  // أغلق قاعدة البيانات
  // await database.close();
  
  EasyLoading.showSuccess('Successfully save to mysql');
}
//    Future syncToMysql() async {
//     await ScanInventoryViewModel()
//         .scanInventoryDatabaseHelper
//         .retrieveDataFromSqlite()
//         .then((userList) async {
//       EasyLoading.show(status: 'Dont close app. we are sync...');
//       await ScanInventoryViewModel().saveToFirestoreRefresh(userList);
//       await ScanInventoryViewModel().scanInventoryDatabaseHelper.deleteTable(tableScanInventory); // إضافة عملية الحذف
//       EasyLoading.showSuccess('Successfully save to mysql');
//     });
// }
    
    return GetBuilder<ScanInventoryViewModel>(
          init: Get.find<ScanInventoryViewModel>(),
          builder:(controller)=>  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TitleWidget(name: '$user',),
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
                      // int quantity=controller.productModel[i].quantity!;
                       int quantity =controller.currentQuantities[i];
                        // التحقق من أن الكمية لا تنقص عن واحد
                        if (quantity < 1) {
                          // عرض رسالة خطأ
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('لا يمكن أن تكون الكمية أقل من واحد'),
                          ));
                          return;
                        }
                        if( await ScanInventoryViewModel.isInternet() == true){
                      controller.addToFirestore(
                        user!,nameInv!,barcodeValue,nameProductValue,date,quantity);
                        print('controller.barcodeList[i]:${controller.barcodeList[i]} and\n controller.barcodeList.length : ${controller.barcodeList.length} ');
                      // عرض رسالة نجاح الترحيل
                      // showSuccessMessage();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('تم الترحيل بنجاح'),
                        ));
                    
                    } else{
                      await  controller.scanInventoryDatabaseHelper.insertData(nameProductValue, barcodeValue,
                        user!, nameInv!, date.toIso8601String(), quantity);
                      // var res = await controller.scanInventoryDatabaseHelper
                      //         .insertData(''' INSERT INTO $tableScanInventory(
                      //           $columnNameProInv,$columnBarcodeInv,$columnEmailInv, $columnNameInv,$columnDateInv,$columnCountInv) 
                      //     VALUES($nameProductValue,$barcodeValue,$email,$nameInv,$date,$quantity)''');
                          print('insert into tableScanInventory in sqlflite : \n');
                          // print(res);
                        // عرض رسالة نجاح الترحيل
                        // showSuccessMessage();
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
                   
                  //  CustomButton(onPressed: (){
                  //   //  Get.to(() => PdfInventoryPreviewPage(barcodes: controller.barcodeList, 
                  //   //     productNames: controller.productNameList,
                  //   //     nameInv: nameInv!, date: date.toString(), count:controller.currentQuantities,));
                      
                  //  }, text:'عرض التقارير',sizeBorder: 5,width: 130)
                 ],
               )     
        ),
          body:  Column(
              children: [
                barWidget(
                  text: nameInv!,
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
                        await ScanInventoryViewModel.isInternet().then((connection){
                          if(connection){
                            syncToMysql();
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
                               Container(
                                height: 50,
                                child: Center(
                                  child: TableCell(
                                    child: Text('الكمية'),
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
                          width: double.infinity,
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
                  width: double.infinity,
                    child: Center(
                      child: TableCell(
                        child: Obx(() {
                          if (controller.productNameList.isNotEmpty 
                          && dataIndex < controller.productNameList.length) {
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
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove,color: Colors.black,size: 20,),
                          onPressed: () {
                            if (controller.currentQuantities[dataIndex] > 1) {
                              controller.updateQuantity(dataIndex,
                                controller.currentQuantities[dataIndex] - 1,
                              );
                            }
                          },
                        ),
                        CustomText(text:'${controller.currentQuantities[dataIndex]}'),
                        IconButton(
                          icon: Icon(Icons.add,color: Colors.black,size: 20,),
                          onPressed: () {
                            controller.updateQuantity(dataIndex,
                              controller.currentQuantities[dataIndex] + 1,
                            );
                          },
                        ),
                      ],
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
