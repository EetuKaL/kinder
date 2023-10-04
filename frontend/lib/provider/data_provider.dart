import 'package:flutter/material.dart';
import 'package:frontend/components/firestore_utilities.dart';

import 'package:frontend/models/profile.dart';

// Provider to hold all the data in the application.

class DataProvider with ChangeNotifier {
  // Privates
  late List<Profile> _availableProfiles;
  bool _loading = false;

  // Getters
  List<Profile> get profiles => _availableProfiles;
  bool get loading => _loading;

  // Methods
  getProfiles() async {
    _loading = true;
    _availableProfiles = await getFirestoreProfiles();
    _loading = false;

    notifyListeners();
  }
}
