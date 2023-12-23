import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class QueryInventoryModel{
  String? namePro,barcode,email,InvName,scanId;
  DateTime? date;
  int? count;

  QueryInventoryModel({this.namePro,this.barcode,this.email,this.InvName,this.count,this.date});

  QueryInventoryModel.fromJson(Map<dynamic,dynamic> map){
    if(map == null){
      return;
    }
    namePro=map['namePro'];
    barcode=map['barcode'];
    email=map['email'];
    date = map['date'] is Timestamp ? (map['date'] as Timestamp).toDate() : null; // تحقق من النوع قبل التحويل
    InvName=map['nameInv'];
    scanId=map['scanId'];
    count=map['count'] is Int ? int.parse(map['count']) : map['count'];
  }
 Map<dynamic,dynamic> toJson(){
    return{
      'namePro': namePro,
      'barcode': barcode,
      'email': email,
      'date':date,
      'nameInv':InvName ,
      'scanId':scanId,
      'count':count.toString()
    };
  }
}
