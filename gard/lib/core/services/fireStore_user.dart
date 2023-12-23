import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    try {
      return await _userCollectionRef.doc(uid).get();
    } catch (e) {
      if (e is FirebaseException && e.code == 'unavailable') {
        // إعادة المحاولة بعد فترة زمنية مؤقتة
        await Future.delayed(Duration(seconds: 5));
        return await getCurrentUser(uid);
      } else {
        // إعادة إثارة الخطأ في حالة وجود خطأ آخر غير المؤقت
        throw e;
      }
    }
  }
}