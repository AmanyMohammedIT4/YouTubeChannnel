import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/query_items_view_model.dart';
import 'package:gard/views/pdf/queryPDF/pdf_queryInv_items.dart';
import 'package:gard/views/pdf/queryPDF/pdf_queryLoc_items.dart';
import 'package:gard/views/widgets/bar_widget.dart';
import 'package:gard/views/widgets/buttons.dart';
import 'package:gard/views/widgets/custom_Text.dart';
import 'package:get/get.dart';

class QueryPDFItemsView extends StatelessWidget {
   QueryPDFItemsView({this.namePro});

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
              
            body: Column(
              children: [
                barWidget(
                  text: namePro!,
                  onTap: () {
                    Get.back();
                  },
                ),
               
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                         CustomButton(
                    width: MediaQuery.of(context).size.width*.8,
                    onPressed: (){
                       Get.to(()=>PDFLocItemsView(reportDataLoc: filteredDataLocation,namePro: namePro!,));
                     }, text: 'عرض التقرير للمواقع'),
                      SizedBox(height: 20,),
                     CustomButton(
                      width: MediaQuery.of(context).size.width*.8,
                    onPressed: (){
                       Get.to(()=>PDFInvItemsView(reportDataInv: filteredDataInventory,namePro: namePro!,));
                     }, text: 'عرض التقرير للمخازن'),
                      ],
                    ),
                  ),
                )
               
                ],
            ), );
  });
 
  }
}