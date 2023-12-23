import 'package:flutter/material.dart';
import 'package:gard/core/services/database/locations_database.dart';
import 'package:gard/core/services/location_service.dart';
import 'package:gard/core/viewModel/scan_view_model.dart';
import 'package:gard/model/locations_model.dart';
import 'package:get/get.dart';

class LocationViewModel extends GetxController{
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<LocationsModel> get locationModel=>_locationModel;
  List<LocationsModel> _locationModel=[];


LocationsDatabaseHelper locationsDatabaseHelper= LocationsDatabaseHelper();

ScanViewModel scan = ScanViewModel();

  LocationViewModel(){
    getLocations();
   
  }
  getLocations()async{
    _loading.value=true;

    LocationService().getLocation().then((value) {
      for(int i=0; i< value.length; i++){
        _locationModel.add(LocationsModel.fromJson(value[i].data() ));
        print('the value length of locations:${value.length}');
         _loading.value=false;
      }
      update();
    });

   
  }
}
