

import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/splash_view_model.dart';
import 'package:get/get.dart';

class SplashView extends GetWidget<SplashViewModel> {
@override
  SplashViewModel get controller => Get.put(SplashViewModel());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashViewModel>(
      init: SplashViewModel(),
      builder: (controller) =>
         Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 150),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .6,
                    child: Image.asset('assets/images/logoYemen.png'),
                  ),
                  SizedBox(height: 20,),
                  CircularProgressIndicator(color: primaryColor),
                  Text(
                    'تطبيق جرد',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff2e386b),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
   
    );
  }
}
