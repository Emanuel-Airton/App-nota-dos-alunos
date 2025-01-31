import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileModel {
  String? userProfileName;
  String? userProfileEmail;
  String? userProfilePassword;
  String? userProfilePhoneNumber;
  String? userProfileUrlImage;

  get getUserProfileName => userProfileName;

  set setUserProfileName(userProfileName) =>
      this.userProfileName = userProfileName;

  get getUserProfileEmail => userProfileEmail;

  set setUserProfileEmail(userProfileEmail) =>
      this.userProfileEmail = userProfileEmail;

  get getUserProfilePassword => userProfilePassword;

  set setUserProfilePassword(userProfilePassword) =>
      this.userProfilePassword = userProfilePassword;

  get getUserProfilePhoneNumber => userProfilePhoneNumber;

  set setUserProfilePhoneNumber(userProfilePhoneNumber) =>
      this.userProfilePhoneNumber = userProfilePhoneNumber;

  get getUserProfileUrlImage => userProfileUrlImage;

  set setUserProfileUrlImage(userProfileUrlImage) =>
      this.userProfileUrlImage = userProfileUrlImage;

  // Construtor principal
  ProfileModel({
    required this.userProfileName,
    required this.userProfileEmail,
    required this.userProfilePhoneNumber,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": userProfileEmail,
      "email": userProfileEmail,
      "telefone": userProfilePhoneNumber,
      "Url Imagem": userProfileUrlImage
    };
    return map;
  }

  // Construtor nomeado para criar uma instância sem dados
  ProfileModel.semDados()
      : userProfileName = '',
        userProfileEmail = '',
        userProfilePhoneNumber = '';

  factory ProfileModel.fromUser(User user) {
    debugPrint("TESTANDO: ${user.displayName}");
    return ProfileModel(
      userProfileName: user.displayName,
      userProfileEmail: user.email,
      userProfilePhoneNumber: user.phoneNumber,
    );
  }
}
