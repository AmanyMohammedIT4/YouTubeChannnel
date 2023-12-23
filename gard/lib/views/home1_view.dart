
import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/views/queries/query_home_view.dart';
import 'package:gard/views/start111_gard_view.dart';
import 'package:gard/views/widgets/buttons.dart';
import 'package:gard/views/widgets/title_widget.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
//   HomeView({this.email});
// String? email;
final controller = Get.find<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false,
         
        title:TitleWidget(name:'$user' ,),
       
         ),
      body: Column(
        children: [
           SizedBox(
            height: 20.0,
            child: Divider(
              color: kbarColor,
              thickness: 3,
            ),
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
                        Get.to(()=>StartGardView(),transition: Transition.rightToLeft);
                       }, 
                      text: 'البدأ بالجرد',),
                  ),
                    SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width * .6,
                    child: CustomButton(
                      onPressed: () { 
                        Get.to(()=>QueryHomeView());
                       }, 
                      text: 'الاستعلام',),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  
  }
}