import 'package:cloud_firestore/cloud_firestore.dart';

class QueryLocationService{
  
  final CollectionReference _queryLocationCollectionRef = FirebaseFirestore.instance.collection('scanningBarcode');

  Future<List<QueryDocumentSnapshot<dynamic>>> getQueryLocation() async{
    var value = await _queryLocationCollectionRef.get();
    return value.docs;
  }
}
