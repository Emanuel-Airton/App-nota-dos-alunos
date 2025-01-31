import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/auth/views/login_page.dart';

// ignore: must_be_immutable
class CustomPasswordResetDialog extends StatelessWidget {
  late String texto;
  CustomPasswordResetDialog({super.key, required this.texto});
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.40,
              //   height: size.height * 0.40,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        const Color(0xFFEFEFEF)
                      ]),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/images/email-enviado.png',
                  width: size.width * 0.25,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Email enviado",
              style: CustomTextStyle.titleLargeLogin,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Se o endereço $texto estiver registrado, um link de redefinição de senha foi enviado.',
              style: CustomTextStyle.titleSmallLogin,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: Text(
                  'ok',
                  style: CustomTextStyle.fontButtom,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
