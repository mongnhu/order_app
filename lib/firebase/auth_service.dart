import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/models/signup_model.dart';

class AuthService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isEmailRegistered(String email) async {
    final querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> login(String email, String password) async {
    try {
      // Retrieve user document by email
      final querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;

        // Check if the provided password matches the stored password
        // Make sure you are hashing passwords and comparing hashes in production!
        if (userDoc['password'] == password) {
          // Login successful
          return true; // User logged in successfully
        } else {
          // Incorrect password
          return false;
        }
      } else {
        // User not found
        return false;
      }
    } catch (e) {
      // Handle exceptions, e.g., logging the error
      print("Login failed: $e");
      return false;
    }
  }

  Future<void> registerUser(SignUpModel user) async {
    try {
      // Register user with Firebase Auth
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Store additional user info in Firestore
      await usersCollection.doc(userCredential.user?.uid).set(user.toMap());
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}
