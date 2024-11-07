import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static final instance = AuthHelper._();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Login with Email and Password -----------------------------------------
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userAuth.user;
    } catch (e) {
      rethrow;
    }
  }

  // Sign Up with Email and Password --------------------------------------
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userAuth.user;
    } catch (e) {
      rethrow;
    }
  }

  // Authentication State Changes -----------------------------------------
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  // Get Current User -------------------------------------------------------
  User? get currentUser => _firebaseAuth.currentUser;

  // Logout ----------------------------------------------------------------
  Future<void> logout() async => await _firebaseAuth.signOut();

  // Password Reset --------------------------------------------------------
  Future<void> passwordReset(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Phone Number Verification --------------------------------------------
  Future<void> verifyPhoneNum(
      String? phoneNumber, String? verificationId) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          // Handle the sent verification code
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      rethrow;
    }
  }
}
