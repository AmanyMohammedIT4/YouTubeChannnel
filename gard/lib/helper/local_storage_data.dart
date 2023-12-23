
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gard/constants.dart';
import 'package:gard/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageData extends GetxController{

  Future get getUser async{
    try{
      UserModel userModel=await _getUserData();
      if(userModel == null){
        return null;
        //throw Exception('User data is null'); // رمي استثناء في حالة عدم توفر بيانات المستخدم
      }
      return userModel;
    }on FirebaseAuthException catch(e){
       print(e.toString());
      return null;
    }
  }
  
  _getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(CACHED_USER_DATA);
    return UserModel.fromJson(json.decode(value!));
  }
  setUser(UserModel userModel)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CACHED_USER_DATA, json.encode(userModel.toJson()));
  }
  //for delete user when signOut
  void deleteUser()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.clear();
  }
}