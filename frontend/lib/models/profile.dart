import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/data/db.dart';

class Profile {
  final DocumentReference? ref;
  final String name;
  final int age;
  final String? job;
  final String? jobAt;
  final List<dynamic> imageUrls;

  /// gender value semantics true: man false: woman null: something else.
  final bool? gender;

  /// jobstatus value semantics true: employeed false: unemployeed null: doesn't want to tell.
  final bool? jobStatus;
  Profile({
    this.ref,
    required this.name,
    required this.age,
    required this.job,
    required this.jobAt,
    required this.imageUrls,
    required this.gender,
    required this.jobStatus,
  });

  static Profile fromSnapShot(
          DocumentReference ref, QueryDocumentSnapshot snap) =>
      Profile(
          name: snap.get('name') as String,
          age:
              (DateTime.now().difference((snap.get('age') as DateTime)).inDays /
                      365)
                  .toInt(),
          jobStatus: snap.tryGet<bool>('jobStatus'),
          job: snap.tryGet<String>('job'),
          gender: snap.tryGet<bool>('gender'),
          jobAt: snap.tryGet<String>('jobAt'),
          imageUrls: snap.get('imageUrls') as List<String>);

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'job': job,
        'jobAt': jobAt,
        'imageUrls': imageUrls
      };
}
