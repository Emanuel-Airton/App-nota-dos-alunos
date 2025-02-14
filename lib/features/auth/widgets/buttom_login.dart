import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/auth/models/auth_model.dart';
import 'package:flutter_app/features/auth/provider/auth_user_provider.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/auth/widgets/snackbar.dart';
import 'package:flutter_app/features/profile/models/profile_models.dart';
import 'package:flutter_app/features/profile/provider/profile_provider.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ButtomLogin extends StatefulWidget {
  late String emailcontroller;
  late String senhacontroller;
  final GlobalKey<FormState> formKey;

  ButtomLogin(
      {required this.emailcontroller,
      required this.senhacontroller,
      required this.formKey});

  @override
  State<ButtomLogin> createState() => _ButtomLoginState();
}

class _ButtomLoginState extends State<ButtomLogin> {
  @override
  Widget build(BuildContext context) {
    final SnackBarWidget snackBarWidget = SnackBarWidget();
    return TextButton(
      onPressed: () async {
        if (widget.formKey.currentState!.validate()) {
          try {
            User? user =
                await sign(widget.emailcontroller, widget.senhacontroller);
            if (user != null) {
              Navigator.push(context,
                  Routes().generateRoutes(const RouteSettings(name: "email")));
            }
          } catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBarWidget.snackbar(context, e.toString()));
          }
        }
      },
      child: Text('Entrar', style: CustomTextStyle.fontButtom),
    );
  }

  sign(String emailcontroller, String senhacontroller) async {
    final authuserProvider =
        Provider.of<AuthUserProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    AuthService authService = AuthService();
    AuthModel authModel = AuthModel(
      widget.emailcontroller,
      widget.senhacontroller,
    );
    User user = await authService.siginFirebaseAuth(authModel);
    authuserProvider.setUser(user);
    ProfileModel profileModel = ProfileModel.fromUser(user);
    profileProvider.setProfile(profileModel);
    return user;
  }
}
