import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

extension FirebaseFirestoreX on FirebaseFirestore {
  Stream<T> getStream<T>(String collection,
      T Function(QuerySnapshot<Map<String, dynamic>> snap) converter) {
    return db.collection(collection).snapshots().map((snap) => converter(snap));
  }
}

extension QueryDocumentSnapshotX on QueryDocumentSnapshot {
  T? tryGet<T>(String target) {
    try {
      return get('target') as T;
    } catch (e) {
      return null;
    }
  }
}
