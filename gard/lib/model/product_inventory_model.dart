class ProductInventoryModle{
  String? barcode,namePro;
  int? quantity;

  ProductInventoryModle({this.barcode,this.namePro,this.quantity});

  ProductInventoryModle.fromJson(Map<dynamic,dynamic> map){
    if(map == null){
      return;
    }
    barcode=map['barcode'];
    namePro=map['namePro'];
    quantity = map['quantity'] is String ? int.parse(map['quantity']) : map['quantity'];
  }
 toJson(){
    return{
      'barcode':barcode,
      'namePro':namePro,
      'quantity':quantity.toString(),
    };
  }
}

