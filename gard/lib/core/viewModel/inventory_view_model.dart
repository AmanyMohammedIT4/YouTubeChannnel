import 'package:flutter/material.dart';
import 'package:gard/core/services/inventory_service.dart';
import 'package:gard/model/inventory_model.dart';
import 'package:get/get.dart';

class InventoryViewModel extends GetxController{
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<InventoryModel> get inventoryModel=>_inventoryModel;
  List<InventoryModel> _inventoryModel=[];

  InventoryViewModel(){
    getInventories();
  }
  getInventories()async{
    _loading.value=true;

    InventoryService().getInventory().then((value) {
      for(int i=0; i< value.length; i++){
        _inventoryModel.add(InventoryModel.fromJson(value[i].data() ));
        print('the value length of inventory :${value.length}');
         _loading.value=false;
      }
      update();
    });

   
  }
}