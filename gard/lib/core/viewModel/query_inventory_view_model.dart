// 
import 'package:flutter/material.dart';
import 'package:gard/core/services/query_inventory_service.dart';
import 'package:gard/model/query_inventory_model.dart';
import 'package:get/get.dart';


class QueryInventoryViewModel extends GetxController{

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<QueryInventoryModel> get queryInventoryModel=>_queryInventoryModel;
  List<QueryInventoryModel> _queryInventoryModel=[];

  QueryInventoryViewModel(){
     getQueryInventory();
  }

  getQueryInventory()async{
    _loading.value=true;

    QueryInventoryService().getQueryInventory().then((value) {
      for(int i=0; i< value.length; i++){
        _queryInventoryModel.add(QueryInventoryModel.fromJson(value[i].data() ));
        print('the value length of query Inventory:${value.length}');
        
         _loading.value=false;
      }
      update();
    });
  }
}