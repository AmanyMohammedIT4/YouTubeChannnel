

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/inventory_view_model.dart';
import 'package:gard/core/viewModel/items_view_model.dart';
import 'package:gard/core/viewModel/locations_view_model.dart';
import 'package:gard/core/viewModel/query_inventory_view_model.dart';
import 'package:gard/core/viewModel/query_items_view_model.dart';
import 'package:gard/core/viewModel/query_location_view_model.dart';
import 'package:gard/core/viewModel/scan_Inventory_view_model.dart';
import 'package:gard/core/viewModel/scan_view_model.dart';
import 'package:gard/helper/binding.dart';
import 'package:gard/helper/local_storage_data.dart';
import 'package:gard/views/control_view.dart';
import 'package:gard/views/splash_view.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   Get.put(ControlView());
   Get.put(LocalStorageData());
   Get.put(LocationViewModel());
   Get.put(InventoryViewModel());
   Get.put(ScanViewModel());
   Get.put(QueryLocationViewModel());
   Get.put(ScanInventoryViewModel());
   Get.put(QueryInventoryViewModel());
   Get.put(ItemsViewModel());
   Get.put(QueryItemsViewModel());
   Get.put(AuthViewModel());
 
  runApp( MyApp());
    configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}
class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      builder: EasyLoading.init(),
       localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [Locale("ar", "AE")],
          locale: Locale("ar", "AE"),
           getPages: [
      ],
      // home: Scaffold(
      //   body: ControlView(),
      // ),
      home: Scaffold(
        body: SplashView(),
      ),
    );
  }
}
