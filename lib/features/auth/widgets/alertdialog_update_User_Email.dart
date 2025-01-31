import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/routes/routes.dart';

class AlertDialogUpdateUserEmail extends StatelessWidget {
  const AlertDialogUpdateUserEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(
          'Verifique seu email!',
          style: CustomTextStyle.titleLargeLogin,
        ),
        content: Text(
            style: CustomTextStyle.titleSmallLogin,
            'Foi enviado um email de verificação! Clique no botão abaixo e você será reecaminhado para a tela de login. Se você não verificou novo email poderá continuar usando seu email antigo'),
        actions: [
          TextButton(
              onPressed: () async {
                await AuthService().sigoutFirebaseAuth();
                await AuthService().preferencesRemove();
                Navigator.push(
                    context,
                    Routes().generateRoutes(const RouteSettings(
                      name: "login",
                    )));
              },
              child: const Text('Ir para tela de login'))
        ],
      ),
    );
  }
}
