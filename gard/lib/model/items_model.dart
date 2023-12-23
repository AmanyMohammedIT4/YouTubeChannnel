class ItemsModle{
  String? barcode,name;
  int? itemNum;

  ItemsModle({this.barcode,this.name});

  ItemsModle.fromJson(Map<dynamic,dynamic> map){
    if(map == null){
      return;
    }
    barcode=map['barcode'];
    name=map['name'];
    itemNum=map['itemNum'];
  }
 toJson(){
    return{
      'barcode':barcode,
      'name':name,
      'itemNum':itemNum.toString(),
    };
  }
}

