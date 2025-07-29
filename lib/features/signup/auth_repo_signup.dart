import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthRepo {
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class FirebaseAuthService implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint(" Firebase Signup Error: \${e.code} - \${e.message}");
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      debugPrint("Unknown Signup Error: \$e");
      throw Exception("Unknown error during sign up");
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Login error: \${e.message}");
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      debugPrint("Unknown login error: \$e");
      throw Exception("An unknown error occurred during login.");
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
