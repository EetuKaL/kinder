import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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
      return get(target) as T;
    } catch (e) {
      return null;
    }
  }
}

T? parseOrWarn<T>(T Function() parser, String Function(Object?) warn) {
  try {
    return parser();
  } catch (e) {
    if (kDebugMode) {
      print(warn(e));
    }
    return null;
  }
}
