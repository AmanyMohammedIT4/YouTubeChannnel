import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/core/viewModel/inventory_view_model.dart';
import 'package:gard/core/viewModel/items_view_model.dart';
import 'package:gard/core/viewModel/locations_view_model.dart';
import 'package:gard/core/viewModel/query_inventory_view_model.dart';
import 'package:gard/core/viewModel/query_items_view_model.dart';
import 'package:gard/core/viewModel/query_location_view_model.dart';
import 'package:gard/core/viewModel/scan_Inventory_view_model.dart';
import 'package:gard/core/viewModel/scan_view_model.dart';
import 'package:gard/core/viewModel/splash_view_model.dart';
import 'package:gard/helper/local_storage_data.dart';
import 'package:get/get.dart';

class Binding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => LocationViewModel());
    Get.lazyPut(() => LocalStorageData());
    Get.lazyPut(() => SplashViewModel());
    Get.lazyPut(() => ScanViewModel());
    Get.lazyPut(() => InventoryViewModel());
    Get.lazyPut(() => ScanInventoryViewModel());
    Get.lazyPut(() => QueryLocationViewModel());
    Get.lazyPut(() => QueryInventoryViewModel());
    Get.lazyPut(() => ItemsViewModel());
    Get.lazyPut(() => QueryItemsViewModel());
    
  }
}