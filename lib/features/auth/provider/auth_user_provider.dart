import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthUserProvider extends ChangeNotifier {
  User? _user;

  get user => _user;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
