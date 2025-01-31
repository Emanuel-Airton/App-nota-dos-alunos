import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/models/auth_model.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/auth/widgets/alertdialog_update_User_Email.dart';
import 'package:flutter_app/features/auth/widgets/snackbar.dart';
import 'package:flutter_app/routes/routes.dart';
import '../../../core/app_export.dart';

// ignore: must_be_immutable
class EmailVerification extends StatefulWidget {
  AuthModel? authModel;
  String? newEmail; // Novo e-mail a ser verificado
  EmailVerification({super.key, this.authModel, this.newEmail});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification>
    with WidgetsBindingObserver {
  AuthService authService = AuthService();
  late User user;
  late Timer _timer;
  bool _emailVerifield = false;

  @override
  void initState() {
    super.initState();
    debugPrint('email: ${widget.newEmail}');
    WidgetsBinding.instance.addObserver(this);
    user = authService.getUser();
    // authService.sendVerificationEmail();
    checarNovoEmail();
  }

  iniciartimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checarEmailVerificado();
      // checarEmailVerificado();
    });
  }

  checarNovoEmail() async {
    try {
      if (widget.newEmail != null) {
        await authService.updateUserEmail(widget.newEmail!, widget.authModel!);
        return showDialog(
          context: context,
          builder: (context) {
            return const AlertDialogUpdateUserEmail();
          },
        );
      } else {
        iniciartimer();
      }
    } catch (e) {
      debugPrint('erro: $e');
    }

    //await checarEmailVerificado();
  }

  checarEmailVerificado() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      _emailVerifield = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (_emailVerifield) {
      debugPrint('email verificado: ');
      //_emailVerifield = true;
      _timer.cancel();
      await authService.setPreferences(user.uid);
      ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget()
          .snackbar(context, "Email verificado: ${user.email}"));
      Future.delayed(const Duration(seconds: 5)).then((value) =>
          Navigator.pushReplacement(context,
              Routes().generateRoutes(const RouteSettings(name: "bottomBar"))));
    } else {
      debugPrint("não verificado: ");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (!_timer.isActive) {
        iniciartimer();
      }
    } else if (state == AppLifecycleState.paused) {
      _timer.cancel();
    }
  }

  // ignore: non_constant_identifier_names
  @override
  dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Image.asset(
                  'assets/images/enviar.png',
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.10),
                child: Text(
                  "Verifique seu email!",
                  style: CustomTextStyle.titleLargeLogin,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.10),
                child: Text(
                  "Por motivos de segurança acabamos de enviar um link de verificação por e-mail para o endereço ${user.email}. Verifique a caixa de entrada do seu email e clique no link para confirmar sua identificação e entrar no aplicativo.",
                  style: CustomTextStyle.titleSmallLogin,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.10),
                child: Text(
                  "Não recebeu o email? clique no botão.",
                  style: CustomTextStyle.titleSmallLogin,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      try {
                        authService.sendVerificationEmail();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarWidget().snackbar(
                                context, "Email reenviado para ${user.email}"));
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                        Text('Reenviar', style: CustomTextStyle.fontButtom),
                      ],
                    ),
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
