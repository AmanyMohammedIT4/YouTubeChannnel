import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/views/inventory121_view.dart';
import 'package:gard/views/locations112_view.dart';
import 'package:gard/views/widgets/buttons.dart';
import 'package:gard/views/widgets/custom_Text.dart';
import 'package:gard/views/widgets/title_widget.dart';
import 'package:get/get.dart';

class StartGardView extends StatelessWidget {

final controller = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    final user =controller.user;
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleWidget(name: '$user'),
            GestureDetector(
              onTap: (){
                 Get.back();
              },
              child: Icon(Icons.home,size: 45,)),
          ],
        ),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            children: [
              
              ListTile(
                title: CustomText(text: 'جرد',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30,),
                tileColor: primaryColor,
              ),
                Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Container(
                    width: MediaQuery.of(context).size.width * .6,
                    child: CustomButton(
                      onPressed: () { 
                        Get.to(()=>LocationView());
                       }, 
                      text: 'المواقع',),
                  ),
                    SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width * .6,
                    child: CustomButton(
                      onPressed: () { 
                         Get.to(()=>InventoryView());
                       }, 
                      text: 'المخازن',),
                  ),
                ],
              ),
            ),
          ),
            ],
           ),
         ),
    );
  
  }
}