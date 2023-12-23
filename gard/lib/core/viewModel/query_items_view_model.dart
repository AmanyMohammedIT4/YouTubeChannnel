import 'package:flutter/material.dart';
import 'package:gard/core/services/query_inventory_service.dart';
import 'package:gard/core/services/query_location_service.dart';
import 'package:gard/model/items_model.dart';
import 'package:gard/model/query_inventory_model.dart';
import 'package:gard/model/query_location_model.dart';
import 'package:get/get.dart';

class QueryItemsViewModel extends GetxController{
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<QueryInventoryModel> get queryInventoryModel=>_queryInventoryModel;
  List<QueryInventoryModel> _queryInventoryModel=[];

  List<QueryLocationModel> get queryLocationModel=>_queryLocationModel;
  List<QueryLocationModel> _queryLocationModel=[];

    List<ItemsModle> get itemsModle=>_itemsModle;
    List<ItemsModle> _itemsModle=[];

  QueryItemsViewModel(){
    getQueryItems();
     getQueryLocations();
  }
  getQueryItems()async{
    _loading.value=true;

    QueryInventoryService().getQueryInventory().then((value) {
      for(int i=0; i< value.length; i++){
        _queryInventoryModel.add(QueryInventoryModel.fromJson(value[i].data() ));
        print('the value length of query Inventory items:${value.length}');
         _loading.value=false;
      }
      update();
    });
    

  }
   getQueryLocations()async{
    _loading.value=true;

   QueryLocationService().getQueryLocation().then((value) {
      for(int i=0; i< value.length; i++){
        _queryLocationModel.add(QueryLocationModel.fromJson(value[i].data() ));
        print('the value length of query location items:${value.length}');
        
         _loading.value=false;
      }
      update();
    });
  }
  
}
