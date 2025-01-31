import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/profile/models/profile_models.dart';
import 'package:flutter_app/features/profile/provider/profile_provider.dart';
import 'package:flutter_app/features/profile/services/image_profile_controller.dart';
import 'package:flutter_app/features/profile/widgets/container_profile.dart';
import 'package:flutter_app/theme/custom_text_style.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';
import 'package:provider/provider.dart';
import '../../../core/app_export.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  File? image;
  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<AuthUserProvider>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    ProfileModel profileModel = profileProvider.profileModel;
    // User user = userProvider.user;
    debugPrint(profileModel.userProfileEmail ?? "sem email");

    debugPrint("rebuild");
    return Scaffold(
      body: CustomBackgroundLayout(
        heightContainer: 0.55,
        child3: Container(),
        child1: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0, bottom: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: image == null
                          ? const AssetImage('assets/images/perfil2.png')
                              as ImageProvider
                          : FileImage(image!),
                      radius: 60,
                      backgroundColor: const Color(0xFFEFEFEF),
                      child: Align(
                        alignment: const Alignment(1, 1.2),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              File images =
                                  await ImageProfileController().image();
                              setState(() {
                                image = images;
                              });
                            } catch (e) {
                              debugPrint("erro: $e");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.10,
                            child: const Icon(
                              size: 25,
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              profileModel.userProfileEmail!,
              style: CustomTextStyle.titleLargeWhite,
            )
          ],
        ),
        child2: SingleChildScrollView(
          child: Column(
            children: [
              ContainerProfile(
                textoTop: "Nome de usuario",
                icon: const Icon(Icons.account_box),
                texto: profileModel.userProfileName == null
                    ? "Adicionar nome de usuario"
                    : profileModel.userProfileName!,
                route: "profileDisplayName",
              ),
              ContainerProfile(
                textoTop: "Email",
                icon: const Icon(Icons.email),
                texto: profileModel.userProfileEmail ?? "adicionar email",
                route: "reauthenticate",
              ),
              ContainerProfile(
                textoTop: "Senha",
                icon: const Icon(Icons.lock),
                texto: "Alterar sua senha",
                route: "forgot",
              ),
              Form(
                //  key: key,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        /*  border: Border.all(
                          width: 3,
                          color: Theme.of(context).colorScheme.primary,
                        ),*/
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      /*   child: TextButton(
                        onPressed: () async {},
                        child: const Text('Atualizar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),*/
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
