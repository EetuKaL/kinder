import 'package:frontend/models/profile.dart';

/* Future<List<Profile>> getFirestoreProfiles() async {
  final profiles = <Profile>[];
  print('fetching Document IDs....');
  // final db = FirebaseFirestore.instance;
  final snapshot = await db.collection("users").get();
  for (var doc in snapshot.docs) {
    print("${doc.id} => ${doc.data()}");
    var x = doc.data();
    x["id"] = doc.id;

    profiles.add(Profile.fromJson(x));
  }
  print('returning profiles $profiles');
  return profiles;
} */

Future<List<Profile>> getLocalProfiles() async {
  await Future.delayed(const Duration(seconds: 2));
  return [
    Profile(
      name: 'Alice',
      age: 25,
      job: 'Hiker',
      jobStatus: null,
      jobAt: 'Mountain Club',
      gender: false,
      imageUrls: [
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'
      ],
    ),
    Profile(
      name: 'Bob',
      age: 30,
      gender: true,
      jobStatus: null,
      job: 'Chef',
      jobAt: 'Food Factory',
      imageUrls: [
        'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'
      ],
    ),
    Profile(
      name: 'Charlie',
      age: 28,
      gender: null,
      jobStatus: null,
      job: 'Developer',
      jobAt: 'Tech Corp',
      imageUrls: [
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'
      ],
    ),
    Profile(
      name: 'Diana',
      gender: false,
      jobStatus: null,
      age: 26,
      job: 'Artist',
      jobAt: 'Art Studio',
      imageUrls: [
        'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'
      ],
    )
  ];
}
