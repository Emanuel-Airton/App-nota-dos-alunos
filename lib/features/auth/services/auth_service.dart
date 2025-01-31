import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/features/auth/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? usuario;

  //obtem o usuario atual
  getUser() {
    if (_firebaseAuth.currentUser != null) {
      usuario = _firebaseAuth.currentUser;
    }

    return usuario;
  }

  Future<User> siginFirebaseAuth(AuthModel authModel) async {
    User user;
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: authModel.email, password: authModel.senha);
      user = userCredential.user!;
      !user.emailVerified == false;
      //await setPreferences(user.uid);
      debugPrint("id do usuario logado: ${user.uid}");
      debugPrint("email do usuario logado: ${user.email}");
      debugPrint(user.toString());
      return user;
    } on FirebaseAuthException catch (erro) {
      return Future.error(getExceptionssiginFirebaseAuth(erro));
    }
  }

  //metodo que captura as execões
  String getExceptionssiginFirebaseAuth(FirebaseAuthException erro) {
    switch (erro.code) {
      case 'invalid-credential':
        return 'Email ou senha invalidos!';
      case 'invalid-email':
        return 'Endereço de email invalido!';
      case 'too-many-requests':
        return 'O acesso a esta conta foi temporariamente desativado. Você pode restaurá-lo imediatamente redefinindo sua senha ou tentar novamente mais tarde.';
      default:
        return 'Ocorreu um erro! Tente novamente.';
    }
  }

  setPreferences(String uid) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("uid", uid);
    sharedPreferences.setBool("isLoggedIn", true);
  }

  getpreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? uid = sharedPreferences.getString("uid");
    debugPrint("uid salvo: $uid");
  }

  preferencesRemove() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("email");
    getpreferences();
  }

  sigoutFirebaseAuth() async {
    try {
      await _firebaseAuth.signOut();
      debugPrint(
          "Email do usuario logado: ${_firebaseAuth.currentUser?.email}");
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final uid = sharedPreferences.getString("uid");
    final isLoggedIn = sharedPreferences.getBool("isLoggedIn");

    if (uid != null && isLoggedIn == true) {
      return getUser();
      // return _firebaseAuth.currentUser;
    } else {
      debugPrint("usuario nao logado");
      return null;
    }
  }

  email() async {
    getUser();
    if (usuario != null && !usuario!.emailVerified) {
      await usuario!.sendEmailVerification();
    }
  }

  resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return Future.error(getExceptionsresetPassword(e));
    }
  }

  getExceptionsresetPassword(FirebaseAuthException e) {
    if (e.code == 'invalid-email') {
      return 'Endereço de email invalido!';
    }
  }

  sendVerificationEmail() async {
    User _user = getUser();
    if (!_user.emailVerified) {
      await _user.sendEmailVerification();
      debugPrint('email de verificação enviado');
    }
  }

  Future<void> updateUserEmail(String newEmail, AuthModel authModel) async {
    User user = getUser();
    final credentials = EmailAuthProvider.credential(
        email: authModel.email, password: authModel.senha);
    try {
      // Reautenticar o usuário
      await user.reauthenticateWithCredential(credentials);
      // Atualizar o e-mail com verificação
      await user.verifyBeforeUpdateEmail(newEmail);
      /* await FirebaseFirestore.instance
          .collection('professores')
          .doc('jC8EYv45iHcFIIkgJYHpCpfLKpa2')
          .update({'email': newEmail});*/
    } on FirebaseAuthException catch (e) {
      throw 'erro ao atualizar o email $e';
    } catch (e) {
      debugPrint(e.toString());
      throw 'Erro inesperado ao atualizar o e-mail: $e';
    }
  }
}
