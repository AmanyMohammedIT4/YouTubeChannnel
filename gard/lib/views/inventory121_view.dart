import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/inventory_view_model.dart';
import 'package:gard/views/scanner123_inventory_view.dart';
import 'package:gard/views/widgets/bar_widget.dart';
import 'package:gard/views/widgets/custom_Text.dart';
import 'package:get/get.dart';

class InventoryView extends StatelessWidget {
  // InventoryView({this.email});
  // String? email;
  final controller = Get.find<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return GetBuilder<InventoryViewModel>(
      init:  Get.find<InventoryViewModel>(),
      builder: (controller) => controller.loading.value
          ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator(color:primaryColor,)))
          : Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Icon(Icons.groups, size: 35, color: primaryColor),
                    SizedBox(width: 20),
                    CustomText(
                      text: '$user',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ],
                ),
              ),
              body: Stack(
                children: [
                  
                  barWidget(text: 'المخازن',
                   onTap: () {
                            Get.back();
                          },),
                   Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Expanded(
                      child: GetBuilder<InventoryViewModel>(
                        builder: (controller) {
                          return ListView.builder(
                            itemCount: controller.inventoryModel.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // إنشاء صف الأعمدة
                                return Container(
                                  child: Table(
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 137, 207, 190),
                                        ),
                                        children: [
                                          Container(
                                            height: 50,
                                            child: Center(
                                              child: TableCell(
                                                child: Text('الرقم'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Center(
                                              child: TableCell(
                                                child: Text('الاسم'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                             
                              } else {
                                // إنشاء صفوف البيانات
                                final dataIndex = index - 1;
                                return Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Container(
                                    child: Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            Container(
                                              child: Center(
                                                child: TableCell(
                                                  child: CustomText(
                                                    text: controller.inventoryModel[dataIndex].InvNum.toString(),
                                                    fontSize: 20,),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                  Get.to(()=>ScannerInventoryView(
                                                    nameInv: controller.inventoryModel[dataIndex].InvName!,));
                                                    
                                                },
                                              child: Container(
                                                child: Center(
                                                  child: TableCell(
                                                    child: CustomText(
                                                      text:controller.inventoryModel[dataIndex].InvName!,
                                                      fontSize: 20,
                                                    ),
                                                  ),
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
                          );
                       
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
