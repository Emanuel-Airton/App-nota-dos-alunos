import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/auth/models/auth_model.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/auth/widgets/alertdialog_update_User_Email.dart';
import 'package:flutter_app/features/auth/widgets/container_textField_credentials.dart';
import 'package:flutter_app/routes/routes.dart';

class ProfileUpdateEmail extends StatefulWidget {
  const ProfileUpdateEmail({super.key});

  @override
  State<ProfileUpdateEmail> createState() => _ProfileUpdateEmailState();
}

class _ProfileUpdateEmailState extends State<ProfileUpdateEmail> {
  final key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailController2 = TextEditingController();

  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaResetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = EdgeInsets.symmetric(horizontal: size.width * 0.1);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 80),
              child: GestureDetector(
                onTap: () => Navigator.pop(
                  context,
                ),
                child: const Icon(Icons.close),
              ),
            ),
            Padding(
              padding: padding,
              child: Form(
                key: key,
                child: Column(
                  children: [
                    Text(
                      "Atualizar email",
                      style: CustomTextStyle.titleLargeLogin,
                    ),
                    Text(
                      "Insira seu email e senha atual, além do novo email para fazer a atualização ",
                      style: CustomTextStyle.titleSmallLogin,
                    ),
                    const SizedBox(height: 20),
                    ContainerTextField(
                        controller: emailController, hintText: "email"),
                    const SizedBox(height: 20),
                    ContainerTextField(
                        controller: senhaController, hintText: "senha"),
                    const SizedBox(height: 20),
                    ContainerTextField(
                        controller: emailController2, hintText: "novo email"),
                    const SizedBox(height: 20),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                            onPressed: () async {
                              AuthModel authModel = AuthModel(
                                  emailController.text, senhaController.text);
                              try {
                                AuthService authService = AuthService();
                                await authService
                                    .updateUserEmail(
                                        emailController2.text, authModel)
                                    .then((value) => showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialogUpdateUserEmail();
                                        }));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$e')));
                              }
                            },
                            child: const Text(
                              'Atualizar',
                              style: TextStyle(color: Colors.white),
                            ))),
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
    );
  }
}
