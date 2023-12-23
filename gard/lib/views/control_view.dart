import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/views/auth/login_view.dart';
import 'package:gard/views/home1_view.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget{
  @override
  Widget build(BuildContext context){
    return Obx((){
      return (Get.find<AuthViewModel>().user != null)
      ? HomeView()
      : LoginView();
    });
  }
}

