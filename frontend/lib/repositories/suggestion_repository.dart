import 'package:frontend/data/db.dart';
import 'package:frontend/models/profile.dart';

class SuggestionRepository {
  Stream<Iterable<Profile>> fetchSuggestions() => db.getStream(
      'users',
      (snap) =>
          snap.docs.map((doc) => Profile.fromSnapShot(doc.reference, doc)));
}
