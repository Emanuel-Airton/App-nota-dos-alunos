import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/profile/models/profile_models.dart';
import 'package:flutter_app/features/profile/provider/profile_provider.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  delay() {
    Future.delayed(const Duration(seconds: 5))
        .then((value) => checkLoggedUser());
  }

  User? _user;
  checkLoggedUser() async {
    _user = await AuthService().getCurrentUser();
    debugPrint(_user?.email);
    if (_user == null || _user?.emailVerified == false) {
      debugPrint(
          "Usuario nulo ou com email não verificado, enviando para a pagina de login");
      navigateLogin();
    } else {
      debugPrint("Email logado: ${_user?.email}" ?? "Usuario não logado");
      provider(_user!);
      navigateBottom();
    }
  }

  provider(User user) {
    ProfileModel profileModel = ProfileModel.fromUser(user);
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.setProfile(profileModel);
    String? email = provider.profileModel.userProfileEmail;
    debugPrint(email ?? "vazio");
  }

  navigateBottom() {
    Navigator.pushReplacement(context,
        Routes().generateRoutes(const RouteSettings(name: "bottomBar")));
  }

  navigateLogin() {
    Navigator.push(
        context, Routes().generateRoutes(const RouteSettings(name: "login")));
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    delay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/dirio_books_2_removebg_preview_1.png',
                  ),
                ),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.height * 0.30,
              ),
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
