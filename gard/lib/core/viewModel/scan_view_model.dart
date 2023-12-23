
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/services/database/items_database.dart';
import 'package:gard/core/services/database/scan_location_database.dart';
import 'package:gard/model/items_model.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ScanViewModel extends GetxController{

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


List<String> barcodeList = <String>[].obs;
List<String> productNameList = <String>[].obs;
ItemsDatabaseHelper? productDBHelper  ;

ScanLocationDatabaseHelper scanLocationDatabaseHelper = ScanLocationDatabaseHelper();

final conn = ScanLocationDatabaseHelper.instance;

 ValueNotifier<bool> get loading => _loading;
 ValueNotifier<bool> _loading = ValueNotifier(false);

List<ItemsModle> get productModel => _productModel;
List<ItemsModle> _productModel = []; 

@override
  void onInit() {
    super.onInit();

  }

  Future<void> scanBarcodeNormal()async{
    String barcodeScanRes;
  try{
      barcodeScanRes=await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 
      'cancel', 
      true, 
      ScanMode.BARCODE);
      debugPrint(barcodeScanRes);
      addToBarcodeList(barcodeScanRes);
      print('barcode : ${barcodeScanRes} oooooooooooooooooooooooooooooooo');
  }on PlatformException{
    barcodeScanRes='Faild to get platform version.';
  }
  }
  
 void addToBarcodeList(String barcode) {
  barcodeList.add(barcode);
  checkBarcodeExists(barcode);
  _loading.value=true;
  update();
  _loading.value=false;
}

void clearBarcodeList(){
  barcodeList.clear();
  update();
}


Future<List<Map<dynamic, dynamic>>> getDataProduct() async {
  try {
    productNameList = [];

    var querySnapshot = await FirebaseFirestore.instance
        .collection(tableProduct)
        .where(columnBarcode, isEqualTo: barcodeList)
        .get();

    int productCounter = 1; 

    List<Map<dynamic, dynamic>> result = querySnapshot.docs.map((doc) => doc.data()).toList();

    querySnapshot.docs.forEach((doc) {
      String productName = doc['name'];
      productNameList.add('$productCounter.$productName'); 
      productCounter++;
    });

    return result;
  } catch (error) {
    print('Error: $error');
    return [];
  }
}


void addToFirestore(String email, String nameLocation,String barcodeLists,String productName,DateTime date) async {
   for(int i=0 ; i< barcodeList.length; i++){
   try {
        print('barcodeList.length in scan view model: ${barcodeList.length}');
        
        final CollectionReference collection = FirebaseFirestore.instance.collection('scanningBarcode');
    await collection.add({
      'email': email,
      'locationName': nameLocation,
      'barcode': barcodeLists,
      'name': productName,
      'date':date
    });
     update();
        print('تمت عملية الإضافة إلى Firestore بنجاح');
    
     
  } catch (e) {
    print('حدث خطأ: $e');
  } }

}


Future<void> saveToFirestoreRefresh(List<Map<String, dynamic>> data) async {
  
  CollectionReference collection =
      FirebaseFirestore.instance.collection('scanningBarcode');

  // حفظ كل سجل في مستند منفصل في Firestore
  for (var record in data) {
    await collection.add(record);
  }

  // حذف البيانات من الجدول
  await scanLocationDatabaseHelper.deleteTable(tableScanLocation);
  
  // أغلق قاعدة البيانات
  // await scanLocationDatabaseHelper.closeDatabase();
  
  update();
}



void checkBarcodeExists(String barcode) {
  if (_loading.value) {
    return;
  }
  _loading.value=true;

  FirebaseFirestore.instance
    .collection('products')
    .where('barcode', isEqualTo: barcode)
    .get()
    .then((QuerySnapshot querySnapshot) {
     if (querySnapshot.docs.isNotEmpty) {
        String productName = querySnapshot.docs.first['name'];
        productNameList.add(productName);
        print('Product Name: $productName');
      } else {
        print('Invalid Barcode');
        removeFromBarcodeList(barcode);
      }

      _loading.value=false;
      update();
    })
    .catchError((error) {
      print('Error querying Firestore: $error');
     
      _loading.value=false;
    });
}

void removeFromBarcodeList(String barcode) {
  barcodeList.remove(barcode);
 
  }



}