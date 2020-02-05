import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static Future<AuthResult> login(final String email, final String password) async {
    final AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
    return result;
  }
}