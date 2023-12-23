class InventoryModel{
  String? InvName,InvID;
  int? InvNum;

  InventoryModel({this.InvName,this.InvNum,this.InvID});

  InventoryModel.fromJson(Map<dynamic,dynamic> map){
    if(map == null){
      return;
    }
    InvName=map['name'];
    InvNum=map['number'];
    InvID=map['Id'];
  }
 Map<dynamic,dynamic> toJson(){
    return{
      'name':InvName,
      'number':InvNum.toString(),
      'Id':InvID
    };
  }
}

