import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthLoginRepo {
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class FirebaseAuthLoginService implements AuthLoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      debugPrint("Login error: ${e.message}");
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  
  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
