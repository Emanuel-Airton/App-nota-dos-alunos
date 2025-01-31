import 'package:flutter/material.dart';
import 'package:flutter_app/features/profile/models/profile_models.dart';

class ProfileProvider extends ChangeNotifier {
  // Inicializa com uma instância vazia
  ProfileModel _profileModel = ProfileModel.semDados();

  ProfileModel get profileModel => _profileModel;

  void setProfile(ProfileModel profileModel) {
    debugPrint(
        "Valor do email passado ao provider: ${profileModel.userProfileEmail}");
    _profileModel = profileModel;
    notifyListeners();
  }
}
