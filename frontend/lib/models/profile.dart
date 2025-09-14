import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/data/db.dart';
import 'package:frontend/generated/l10n.dart';

class Profile {
  final DocumentReference? ref;
  final String name;
  final int age;
  final String? job;
  final String? jobAt;
  final List<String> imageUrls;

  final bool? _gender;
  String getgender(S s) => _gender == true
      ? s.male
      : _gender == false
          ? s.female
          : s.other;

  final bool? _jobStatus;
  String getjobStatus(S s) => _jobStatus == true
      ? s.employed
      : _jobStatus == false
          ? s.unemployed
          : s.prefer_not_to_say;
  Profile({
    this.ref,
    required this.name,
    required this.age,
    required this.job,
    required this.jobAt,
    required this.imageUrls,
    bool? gender,
    bool? jobStatus,
  })  : _gender = gender,
        _jobStatus = jobStatus;

  static Profile fromSnapShot(
          DocumentReference ref, QueryDocumentSnapshot snap) =>
      Profile(
          name: snap.get('name') as String,
          age: (DateTime.now()
                      .difference(
                          (DateTime.parse(snap.get('birthDate') as String)))
                      .inDays /
                  365)
              .toInt(),
          jobStatus: snap.tryGet<bool>('jobStatus'),
          job: snap.tryGet<String>('job'),
          gender: snap.tryGet<bool>('gender'),
          jobAt: snap.tryGet<String>('jobAt'),
          imageUrls: List<String>.from((snap.get('imageUrls') as List? ?? [])));

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'job': job,
        'jobAt': jobAt,
        'imageUrls': imageUrls
      };
}
