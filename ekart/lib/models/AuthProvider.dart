import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a user document in Firestore
      await _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'email': email,
        'username': username,
      });

      return userCredential;
    } catch (e) {
      print('Error creating account: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check if a user is signed in
  bool isUserSignedIn() {
    return _auth.currentUser != null;
  }

  // Get the current user's UID
  String? getCurrentUserUid() {
    return _auth.currentUser?.uid;
  }

// ... other methods ...
}