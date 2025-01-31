import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import '../core/app_export.dart';

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  CustomDialog({super.key, required controle});
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topCenter,
              color: Theme.of(context).colorScheme.primary,
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Insira o email para receber a nova senha!",
                    style: CustomTextStyle.fontAlertDialog,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira o email!";
                      } else {
                        return null;
                      }
                    },
                    controller: controller,
                    decoration:
                        CustomTextField.textField(hint: "Insira o email")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      try {
                        await AuthService()
                            .resetPassword(email: controller.text);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Email enviado para ${controller.text}!"),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Erro ao enviar email: $e")),
                        );
                      }
                    }
                  },
                  child: Text(
                    "Enviar",
                    style: CustomTextStyle.fontButtom,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
