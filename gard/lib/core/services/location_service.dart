import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService{
  
  final CollectionReference _locationCollectionRef = FirebaseFirestore.instance.collection('Locations');

  Future<List<QueryDocumentSnapshot<dynamic>>> getLocation() async{
    var value = await _locationCollectionRef.get();
    return value.docs;
  }
}
