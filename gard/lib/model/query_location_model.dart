import 'package:cloud_firestore/cloud_firestore.dart';

class QueryLocationModel{
  String? namePro,barcode,email,locName,scanId;
  DateTime? date;

  QueryLocationModel({this.namePro,this.barcode,this.email,this.locName,this.date});

  QueryLocationModel.fromJson(Map<dynamic,dynamic> map){
    if(map == null){
      return;
    }
    namePro=map['name'];
    barcode=map['barcode'];
    email=map['email'];
    date = map['date'] is Timestamp ? (map['date'] as Timestamp).toDate() : null; // تحويل Timestamp إلى DateTime
    locName=map['locationName'];
    scanId=map['scanId'];
  }
 Map<dynamic,dynamic> toJson(){
    return{
      'name': namePro,
      'barcode': barcode,
      'email': email,
      'date':date,
      'locationName':locName ,
      'scanId':scanId
    };
  }
}
