import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/models/profile.dart';

Future<List<Profile>> getFirestoreProfiles() async {
  List<Profile> profiles = [];
  print('fetching Document IDs....');
  var db = await FirebaseFirestore.instance;
  await db.collection("users").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
      var x = doc.data();
      x["id"] = doc.id;

      profiles.add(Profile.fromJson(x));
    }
    print('profile list include: $profiles');
  }).onError((error, stackTrace) {
    throw ('error $error');
  });
  print('returning profiles $profiles');
  return profiles;
}
