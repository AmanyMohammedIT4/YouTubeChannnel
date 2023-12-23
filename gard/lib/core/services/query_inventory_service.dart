import 'package:cloud_firestore/cloud_firestore.dart';

class QueryInventoryService{
  
  final CollectionReference _queryInventoryCollectionRef = FirebaseFirestore.instance.collection('scanBarcodeInventory');

  Future<List<QueryDocumentSnapshot<dynamic>>> getQueryInventory() async{
    var value = await _queryInventoryCollectionRef.get();
    return value.docs;
  }
}
