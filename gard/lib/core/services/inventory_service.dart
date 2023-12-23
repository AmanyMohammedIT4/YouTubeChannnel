import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryService{
  
  final CollectionReference _inventoryCollectionRef = FirebaseFirestore.instance.collection('inventories');

  Future<List<QueryDocumentSnapshot<dynamic>>> getInventory() async{
    var value = await _inventoryCollectionRef.get();
    return value.docs;
  }
}