import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kinderfrontend/models/profile.dart';

Future<List<Profile>> getFirestoreProfiles() async {
  final profiles = <Profile>[];
  print('fetching Document IDs....');
  final db = FirebaseFirestore.instance;
  final snapshot = await db.collection("users").get();
   for (var doc in snapshot.docs  ) {
      print("${doc.id} => ${doc.data()}");
      var x = doc.data();
      x["id"] = doc.id;

      profiles.add(Profile.fromJson(x));
   }
  print('returning profiles $profiles');
  return profiles;
}

Future<List<Profile>> getLocalProfiles() async {
  await Future.delayed(const Duration(seconds: 2));
  return [
    
    Profile(
        id: '1',
        name: 'Alice',
        age: 25,
        job: 'Hiker',
        jobAt: 'Mountain Club',
        imageUrls: [
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'
        ],
    ),
    Profile(
        id: '2',
        name: 'Bob',
        age: 30,
       
        job: 'Chef',
        jobAt: 'Food Factory',
        imageUrls: [
          'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'
        ],
    ),
    Profile(
        id: '3',
        name: 'Charlie',
        age: 28,
        job: 'Developer',
        jobAt: 'Tech Corp',
        imageUrls: [
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'
        ],
    ),
    Profile(
        id: '4',
        name: 'Diana',
        age: 26,
        job: 'Artist',
        jobAt: 'Art Studio',
        imageUrls: [
          'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'
        ],
    )
  ];
}