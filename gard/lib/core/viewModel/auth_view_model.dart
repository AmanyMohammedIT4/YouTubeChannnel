
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gard/core/services/fireStore_user.dart';
import 'package:gard/helper/local_storage_data.dart';
import 'package:gard/model/user_model.dart';
import 'package:gard/views/home1_view.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthViewModel extends GetxController{
   static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await InternetConnectionChecker().hasConnection) {
        print("Mobile data detected & internet connection confirmed.");
        return true;
      } else {
        print('No internet :( Reason:');
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await InternetConnectionChecker().hasConnection) {
        print("wifi data detected & internet connection confirmed.");
        return true;
      } else {
        print('No internet :( Reason:');
        return false;
      }
    } else {
      print(
          "Neither mobile data or WIFI detected, not internet connection found.");
      return false;
    }
  }


  FirebaseAuth _auth = FirebaseAuth.instance;
  String? email,password;
 final LocalStorageData localStorageData= Get.find<LocalStorageData>();

  Rxn<User> _user=Rxn<User>();
  
 String? get user=> _user.value?.email;

 UserModel? get userModel => _userModel;
 UserModel? _userModel;
 
  @override
  void onInit() {
    super.onInit();
      _user.bindStream(_auth.authStateChanges());
    if(_auth.currentUser != null){
      getcurrentUserData(_auth.currentUser!.uid);
    }
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void signInWithEmailPassword()async{
    try{
      await _auth.signInWithEmailAndPassword(email: email!, password: password!).then((value)async{
        getcurrentUserData(value.user!.uid);
        print('email: ${value.user!.email}');
        
      Get.offAll(() => HomeView());
      });
      // Get.offAll(()=>ControlView());
      

    }on FirebaseAuthException catch(e){
      Get.snackbar("Error Login account", e.message.toString(),
      colorText: Colors.black,snackPosition: SnackPosition.BOTTOM);
    }
  }
// void saveUser(UserCredential user)async{
//   UserModel userModel = UserModel(
//     userId: user.user!.uid,
//     email: user.user!.email,
//     name:'',
//     pic:'');
//     await FireStoreUser().addUserToFireStore(userModel);
//     setUser(userModel);
// }
//  void getcurrentUserData(String uid) async {
//   await FireStoreUser().getcurrentUser(uid).then((value) async {
//     if (value.data() != null) {
//       setUser(UserModel.fromJson(value.data() as Map<dynamic, dynamic>));
//       print(value);
//     } else {
//      print('error null value');
//     }
//   });
// }
void getcurrentUserData(String uid) async {
  await FireStoreUser().getCurrentUser(uid).then((value) async {
    print(value.data());
    if (value.data() != null) {
      setUser(UserModel.fromJson(value.data() as Map<dynamic, dynamic>));
      print('value:${value}');
    } else {
      print('error null value');
    }
  });
}
  void setUser(UserModel userModel)async{
    await localStorageData.setUser(userModel);
  }
}