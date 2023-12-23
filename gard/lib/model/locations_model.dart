class LocationsModel{
  String? locName,locID;
  int? locNum;

  LocationsModel({this.locName,this.locNum,this.locID});

  LocationsModel.fromJson(Map<dynamic,dynamic> map){
    if(map == null){
      return;
    }
    locName=map['name'];
    locNum=map['number'];
    locID=map['LocID'];
  }
 Map<dynamic,dynamic> toJson(){
    return{
      'name':locName,
      'number':locNum.toString(),
      'LocID':locID
    };
  }
}

