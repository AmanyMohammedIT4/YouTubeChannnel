
import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/query_inventory_view_model.dart';
import 'package:gard/views/pdf/queryPDF/pdf_query_inventory.dart';
import 'package:gard/views/widgets/bar_widget.dart';
import 'package:gard/views/widgets/buttons.dart';
import 'package:gard/views/widgets/custom_Text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class QueryInventoryScanView extends StatelessWidget {
   QueryInventoryScanView({this.invName});

String? invName;

final controller = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return GetBuilder<QueryInventoryViewModel>(
      init:  Get.find<QueryInventoryViewModel>(),
      builder: (controller) {
        if(controller.loading.value){
          return  Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator(color:primaryColor,)));
        }
        else{
           final filteredData = controller.queryInventoryModel
                            .where((data) => data.InvName == invName)
                            .toList();
          return   Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: Icon(Icons.groups, size: 35, color: primaryColor)),
                    Container(
                      child: CustomText(
                        text: '$user',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                     Container(
                       child: CustomButton(
                        width: 120,
                        height: 55,
                         onPressed: () { 
                          Get.to(()=>PDFInventoryView(reportData:filteredData,invName: invName!,));
                         },
                          text: 'عرض التقرير',),
                     ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    
                    barWidget(text: invName!,
                     onTap: () {
                              Get.back();
                            },),
                     Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Expanded(
                        child: GetBuilder<QueryInventoryViewModel>(
                          builder: (controller) {
                        return    Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                                child: Table(
                                  border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(color: TbarColor),
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "الباركود",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          flex: 3,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "الاسم",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "المخزن",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        
                                      ],
                                    ),
                                    ...filteredData.map((i) => TableRow(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(i.barcode!),
                                              ),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(i.namePro!),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(i.InvName!),
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
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
      
    );
  }
}