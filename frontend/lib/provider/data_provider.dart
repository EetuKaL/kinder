import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/firestore_utilities.dart';

import 'package:frontend/models/profile.dart';
import 'package:provider/provider.dart';

// Provider to hold all the data in the application.

class DataProvider with ChangeNotifier {
  // Privates
  late List<Profile> _availableProfiles;
  bool _loading = false;

  // Getters
  List<Profile> get profiles => _availableProfiles;
  bool get loading => _loading;

  Future<void> getAvailableProfiles() async {
    _availableProfiles = await getFirestoreProfiles();
    print('fetched profiles is $_availableProfiles');
  }
  // Methods
}
