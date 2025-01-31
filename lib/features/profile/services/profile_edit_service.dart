import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';

class ProfileEditService {
  //FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User user = AuthService().getUser();
  updateProfileName(String name) async {
    try {
      await user.updateDisplayName(name);
      debugPrint("nome atualizado com sucesso");
    } on FirebaseAuthException catch (e) {
      debugPrint("erro: ${e.toString()}");
    }
  }

  verificarNumero() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+55 77 99959-8633',
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {},
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  void reautenticate() async {
    // await user.reauthenticateWithCredential(credential)
  }
}
