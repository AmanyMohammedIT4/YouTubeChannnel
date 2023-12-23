import 'package:flutter/material.dart';
import 'package:gard/core/services/items_service.dart';
import 'package:gard/core/viewModel/scan_view_model.dart';
import 'package:gard/model/items_model.dart';
import 'package:get/get.dart';

class ItemsViewModel extends GetxController{
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<ItemsModle> get itemsModle=>_itemsModle;
  List<ItemsModle> _itemsModle=[];

ScanViewModel scan = ScanViewModel();

  ItemsViewModel(){
    getItems();
   
  }
  getItems()async{
    _loading.value=true;

    ItemsService().getItems().then((value) {
      for(int i=0; i< value.length; i++){
        _itemsModle.add(ItemsModle.fromJson(value[i].data() ));
        print('the value length of Items :${value.length}');
         _loading.value=false;
      }
      update();
    });

   
  }
}
