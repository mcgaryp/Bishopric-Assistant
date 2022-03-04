import 'package:bishop_assistant_web_test_app/firebase/firebase_instances.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/models/account.dart';

///
/// firebase_authentication.dart
/// bishopric-assistant
///
/// Created by Po on 12/30/21
/// Copyright 2021 Po. All rights reserved.
///

// TODO: Update the email or password safely... with FirebaseAuth errors are the following
// The user's credential is no longer valid. The user must sign in again.
class FirebaseAuthentication {
  static final FirebaseAuth auth = FirebaseInstances.auth;

  static User get user {
    if (auth.currentUser != null) return auth.currentUser!;
    throw Exception("User is empty!");
  }

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user.updateDisplayName(name);
      await user.reload();
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) print('The password provided is too weak.');
      }

      if (e.code == 'email-already-in-use') {
        if (kDebugMode) print('The account already exists for that email.');
      }

      if (e.code == 'internal-error') {
        if (kDebugMode) print(e.message);
        throw Exception(e.message);
      }

      if (kDebugMode) print(e);
      throw e.code;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e;
    }
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) print('Wrong password provided.');
      }
      throw e;
    }
    return user;
  }

  static Future<bool> updatePassword(String email, String password) async {
    try {
      await user.updatePassword(password);
      // Create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);

      await user.reload();
      return true;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e;
    }
  }

  static Future<bool> updateEmail(String email, String password) async {
    try {
      await user.updateEmail(email);
      // Create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      UserCredential result =
          await user.reauthenticateWithCredential(credential);

      await user.reload();
      return user.email == result.user?.email;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e;
    }
  }

  static Future<bool> logout() async {
    await auth.signOut();
    return auth.currentUser == null;
  }
}
