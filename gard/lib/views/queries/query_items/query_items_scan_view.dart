import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/query_items_view_model.dart';
import 'package:gard/views/pdf/queryPDF/query_pdf_items_view.dart';
import 'package:gard/views/widgets/bar_widget.dart';
import 'package:gard/views/widgets/buttons.dart';
import 'package:gard/views/widgets/custom_Text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class QueryItemsScanView extends StatelessWidget {
   QueryItemsScanView({this.namePro});

String? namePro;

final controller = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return GetBuilder<QueryItemsViewModel>(
      init:  Get.find<QueryItemsViewModel>(),
      builder: (controller){
          final filteredDataLocation = controller.queryLocationModel
                            .where((data) => data.namePro == namePro)
                            .toList();
           final filteredDataInventory = controller.queryInventoryModel
                            .where((data) => data.namePro == namePro)
                            .toList();                 
        return controller.loading.value
          ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator(color:primaryColor,)))
          : Scaffold(
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
                          Get.to(()=>QueryPDFItemsView(namePro: namePro!,));
                         },
                          text: 'عرض التقرير',),
                     ),
                  ],
                ),
              ),
              
            body: SingleChildScrollView(
                child: Column(
                  children: [
                    barWidget(
                      text: namePro!,
                      onTap: () {
                        Get.back();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Expanded(
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
                                      flex: 2,
                                    ),
                                   
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "الموقع",
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
                                ...filteredDataLocation.map((i) => TableRow(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(i.barcode!),
                                          ),
                                          flex: 2,
                                        ),
                                        
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(i.locName!),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
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
                                ...filteredDataInventory.map((i) => TableRow(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(i.barcode!),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ), );
  });
 
  }
}
