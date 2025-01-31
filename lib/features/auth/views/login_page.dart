import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/auth/widgets/buttom_login.dart';
import 'package:flutter_app/features/auth/widgets/container_image.dart';
import 'package:flutter_app/features/auth/widgets/container_textField_credentials.dart';
import 'package:flutter_app/routes/routes.dart';
import '../../../core/app_export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final key;
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaResetController = TextEditingController();
  AuthService authService = AuthService();
  late String rota;
  @override
  void initState() {
    // TODO: implement initState
    key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    senhaController.dispose();
    senhaResetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = EdgeInsets.symmetric(horizontal: size.width * 0.1);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ContainerImage(),
              //  const SizedBox(height: 10),
              Padding(
                padding: padding,
                child: Form(
                  key: key,
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: CustomTextStyle.titleLargeLogin,
                      ),
                      const SizedBox(height: 20),
                      ContainerTextField(
                          controller: emailController, hintText: "email"),
                      const SizedBox(height: 20),
                      ContainerTextField(
                          controller: senhaController, hintText: "senha"),
                      const SizedBox(height: 20),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ButtomLogin(
                            emailcontroller: emailController.text,
                            formKey: key,
                            senhacontroller: senhaController.text,
                          )),
                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: () {
                            try {
                              Navigator.push(
                                  context,
                                  Routes().generateRoutes(
                                      const RouteSettings(name: "forgot")));
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                            emailController.clear();
                            senhaController.clear();
                            senhaResetController.clear();
                          },
                          child: const Text("Esqueceu a senha?"))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
