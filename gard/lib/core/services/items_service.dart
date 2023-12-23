import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsService{
  
  final CollectionReference _productCollectionRef = FirebaseFirestore.instance.collection('products');

  Future<List<QueryDocumentSnapshot<dynamic>>> getItems() async{
    var value = await _productCollectionRef.get();
    return value.docs;
  }
}