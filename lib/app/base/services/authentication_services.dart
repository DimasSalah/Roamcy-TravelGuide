import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;

import '../../../utils/logging/logger.dart';
import '../../routes/app_pages.dart';
import '../global_model/user_model.dart';

class AuthenticationServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // CREATE USER DOCUMENT FUNCTION
  Future<void> createUserDocument(String id, String firstName, String surName,
      String email, double longitude, double latitude) async {
    try {
      final user = UserModel(
        id: id,
        firstName: firstName,
        surName: surName,
        email: email,
        longitude: longitude,
        latitude: latitude,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .set(user.toJson());
      GLoggerHelper.info('User document created successfully');
    } catch (e) {
      GLoggerHelper.error('Error creating user document: $e');
      rethrow;
    }
  }

  // LOGIN FUNCTION
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      GLoggerHelper.error(e.toString());
      throw Exception(e);
    } catch (e) {
      GLoggerHelper.error(e.toString());
      rethrow;
    }
  }

  // REGISTER FUNCTION
  Future<UserCredential> registerWithEmailAndPassword(
      String firstName,
      String surName,
      String email,
      String password,
      double longitude,
      double latitude) async {
    try {
      print(email);
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await createUserDocument(userCredential.user!.uid, firstName, surName,
          email, longitude, latitude);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      GLoggerHelper.error(e.toString());
      rethrow;
    } catch (e) {
      print(e);
      GLoggerHelper.error(e.toString());
      rethrow;
    }
  }

  // LOGOUT FUNCTION
  Future<void> logout() async {
    await auth.signOut();
  }

  // GOOGLE SIGN IN
  Future<dynamic> signInWithGoogle(
      {double? longitude, double? latitude}) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken == null || googleAuth?.idToken == null) {
        throw 'Google sign in aborted';
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await auth.signInWithCredential(credential);

      // Create user document if it's a new user
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        final user = userCredential.user!;
        await createUserDocument(
          user.uid,
          user.displayName?.split(' ').first ?? '',
          user.displayName?.split(' ').last ?? '',
          user.email ?? '',
          longitude ?? 0.0,
          latitude ?? 0.0,
        );
        Get.offAllNamed(Routes.PLAN);
      } else {
        Get.offAllNamed(Routes.HOME);
      }

      return userCredential;
    } catch (e) {
      GLoggerHelper.error('Error signing in with Google: $e');
      rethrow;
    }
  }

  // APPLE SIGN IN
  Future<UserCredential> signInWithApple(
      {double? longitude, double? latitude}) async {
    try {
      if (!Platform.isIOS) {
        throw 'Apple Sign In is only available on iOS devices';
      }

      // Request credential for the sign-in
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an OAuthCredential
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with the Apple credential
      final userCredential = await auth.signInWithCredential(oauthCredential);

      // For Apple Sign In, we need to handle the user's name separately
      // because Apple only provides the name on the first sign-in
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        final user = userCredential.user!;
        final String firstName = appleCredential.givenName ?? '';
        final String lastName = appleCredential.familyName ?? '';

        await createUserDocument(
          user.uid,
          firstName,
          lastName,
          user.email ?? '',
          longitude ?? 0.0,
          latitude ?? 0.0,
        );
      }

      return userCredential;
    } catch (e) {
      GLoggerHelper.error('Error signing in with Apple: $e');
      rethrow;
    }
  }
}
