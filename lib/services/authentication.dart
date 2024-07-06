import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signEmailPassWord(String email, String password) async {
    try {
      UserCredential authresult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authresult.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
