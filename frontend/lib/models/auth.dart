import 'dart:async';

class Auth {
/*   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser; */

  final _authController = StreamController<bool>.broadcast();

  late final Stream<bool> authStream = _authController.stream;

  void mockLogin() {
    _authController.add(true);
  }

  void mockLogout() {
    _authController.add(false);
  }
/*   Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('value is!!!! $value');
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  } */
}
