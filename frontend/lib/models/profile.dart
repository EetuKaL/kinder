import 'package:flutter/material.dart';

class Profile {
  final int id;
  final String profileName;
  final int profileAge;
  final String profileJob;
  final String profileJobAt;
  final String imageUrls;
  Profile(
      {required this.id,
      required this.profileName,
      required this.profileAge,
      required this.profileJob,
      required this.profileJobAt,
      required this.imageUrls});

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        profileName = json['profileName'],
        profileAge = json['profileAge'],
        profileJob = json['profileJob'],
        profileJobAt = json['profileJobAt'],
        imageUrls = json['imageUrls'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'profileName': profileName,
        'profileAge': profileAge,
        'profileJob': profileJob,
        'profileJobAt': profileJobAt,
        'imageUrls': imageUrls
      };
}
