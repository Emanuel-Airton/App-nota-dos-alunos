import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/auth/widgets/custom_alertDialog.dart';
import 'package:flutter_app/features/auth/widgets/snackbar.dart';
import '../widgets/container_textField_credentials.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  //FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = EdgeInsets.symmetric(horizontal: size.width * 0.1);

    // AuthService authService = AuthService();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: size.width * 0.30,
                        //   height: size.height * 0.40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Colors.grey
                                ]),
                            borderRadius: BorderRadius.circular(100)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            'assets/images/senha-incorreta.png',
                            width: size.width * 0.25,
                          ),
                        ),
                      ),
                      Text(
                        "Redefinir senha",
                        style: CustomTextStyle.titleLargeLogin,
                      ),
                      Text(
                        "Insira seu email para redefinir uma nova senha de acesso do aplicativo",
                        style: CustomTextStyle.titleSmallLogin,
                      ),
                      const SizedBox(height: 20),
                      ContainerTextField(
                          controller: emailController, hintText: "email"),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              try {
                                await AuthService()
                                    .resetPassword(email: emailController.text);
                                //  debugPrint('errorMenssager: $errorMenssager');
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      CustomPasswordResetDialog(
                                    texto: emailController.text,
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarWidget()
                                        .snackbar(context, e.toString()));
                              }
                            }
                          },
                          child:
                              Text('Enviar', style: CustomTextStyle.fontButtom),
                        ),
                      ),
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
