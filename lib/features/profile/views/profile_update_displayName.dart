import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/auth/widgets/snackbar.dart';
import 'package:flutter_app/features/profile/widgets/containerTextField.dart';
import '../services/profile_edit_service.dart';

class ProfileUpdateDisplayName extends StatefulWidget {
  const ProfileUpdateDisplayName({super.key});

  @override
  State<ProfileUpdateDisplayName> createState() =>
      _ProfileUpdateDisplayNameState();
}

class _ProfileUpdateDisplayNameState extends State<ProfileUpdateDisplayName> {
  final key = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var padding = EdgeInsets.symmetric(horizontal: size.width * 0.1);
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
                        textAlign: TextAlign.center,
                        "Atualizar nome de usuario",
                        style: CustomTextStyle.titleLargeLogin,
                      ),
                      Text(
                        "Insira o seu nome de usuario do aplicativo",
                        style: CustomTextStyle.titleSmallLogin,
                      ),
                      const SizedBox(height: 20),
                      ContainerTextField(
                        icon: const Icon(Icons.account_box),
                        controller: displayNameController,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            try {
                              ProfileEditService().updateProfileName(
                                  displayNameController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBarWidget().snackbar(context,
                                      "nome de usuario atualizado com sucesso"));
                              Navigator.pop(context);
                            } catch (e) {
                              debugPrint("erro: ${e.toString()}");
                            }
                            ProfileEditService()
                                .updateProfileName(displayNameController.text);
                          },
                          child:
                              Text('salvar', style: CustomTextStyle.fontButtom),
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
