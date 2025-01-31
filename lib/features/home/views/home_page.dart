import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/disciplinas/models/disciplina_model.dart';
import 'package:flutter_app/features/home/services/home_services.dart';
import 'package:flutter_app/features/home/widgets/column_content_disciplinas.dart';
import 'package:flutter_app/features/home/widgets/popupMenuButton.dart';
import 'package:flutter_app/widgets/container_disciplines.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  late Future<User?> authuser;
  List<String> list = ["sair"];
  late Future<List<Disciplina>> listaDisciplina;
  HomeServices homeServices = HomeServices();
  @override
  void initState() {
    // TODO: implement initState
    //authService.getpreferences();
    authuser = authService.getCurrentUser();
    listaDisciplina = homeServices.loadUserData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: authuser,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.none:
            case ConnectionState.active:
              return const Center(
                child: Text("Sem dados"),
              );
            case ConnectionState.done:
              var dados = snapshot.data;
              //debugPrint(dados?.email ?? "sem dados");
              return CustomBackgroundLayout(
                heightContainer: 0.55,
                child1: Column(
                  children: [
                    Container(
                      // height: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 40,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              dados == null
                                  ? "Usuario não logado"
                                  : 'Olá, ${dados.displayName}',
                              style: CustomTextStyle.titleLargeWhite,
                            ),
                          ),
                          PopupMenuButtonHomePage(list: list),
                        ],
                      ),
                    ),
                  ],
                ),
                child2:
                    ColumnContentDisciplinas(listDisciplina: listaDisciplina),
                child3: Image.asset(
                  'assets/images/dirio_books_1_removebg_preview_1.png',
                  width: MediaQuery.of(context).size.width * 0.45,
                ),
              );
          }
        },
      ),
    );
  }
}
