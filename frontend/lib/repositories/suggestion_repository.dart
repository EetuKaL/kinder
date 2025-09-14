import 'package:frontend/data/db.dart';
import 'package:frontend/models/profile.dart';

class SuggestionRepository {
  Stream<List<Profile>> get suggestionStream => db.getStream(
      'users',
      (snap) => snap.docs
          .map((doc) => parseOrWarn(
              () => Profile.fromSnapShot(doc.reference, doc),
              (e) => 'Failed to parse profile ${doc.reference.path}: $e'))
          .nonNulls
          .toList());
}
