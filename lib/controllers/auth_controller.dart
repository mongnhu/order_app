import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoggedIn = true.obs;

  AuthController() {
    isLoggedIn.value = _auth.currentUser != null;
    _auth.authStateChanges().listen((user) {
      isLoggedIn.value = user != null;
    });
  }

  void logout() async {
    await _auth.signOut();
    isLoggedIn.value = false;
  }
}
