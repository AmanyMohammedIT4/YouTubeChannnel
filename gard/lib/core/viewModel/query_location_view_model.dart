
import 'package:flutter/material.dart';
import 'package:gard/core/services/query_location_service.dart';
import 'package:gard/model/query_location_model.dart';
import 'package:get/get.dart';


class QueryLocationViewModel extends GetxController{
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<QueryLocationModel> get queryLocationModel=>_queryLocationModel;
  List<QueryLocationModel> _queryLocationModel=[];

  QueryLocationViewModel(){
     getQueryLocations();
  }

  getQueryLocations()async{
    _loading.value=true;

    QueryLocationService().getQueryLocation().then((value) {
      for(int i=0; i< value.length; i++){
        _queryLocationModel.add(QueryLocationModel.fromJson(value[i].data() ));
        print('the value length of query location:${value.length}');
        
         _loading.value=false;
      }
      update();
    });
  }
} 