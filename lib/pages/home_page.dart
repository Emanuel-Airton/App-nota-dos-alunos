import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/auth/views/login_page.dart';
import 'package:flutter_app/features/disciplinas/models/disciplina_model.dart';
import 'package:flutter_app/features/disciplinas/services/disciplina_firestore_service.dart';
import 'package:flutter_app/widgets/container_disciplines.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';
import 'package:flutter_app/widgets/future_list_disciplinas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  late Future<User?> authuser;
  String? nome;
  List<String> list = ["sair"];
  late Future<List<Disciplina>> listaDisciplina;
  String userId = "";

  @override
  void initState() {
    // TODO: implement initState
    authService.getpreferences();
    loadUserData();
    super.initState();
  }

  Future<void> loadUserData() async {
    // Obtém o usuário atual e aguarda a resolução
    authuser = authService.getCurrentUser();
    final user = await authuser;

    // Garante que o usuário não seja nulo antes de acessar o 'uid'
    if (user != null) {
      setState(() {
        userId = user.uid;
      });

      // Agora que temos o userId, carregamos a lista de disciplinas
      listaDisciplina =
          DisciplinaFirestoreService().listarDisciplinaProfessor(userId);
    } else {
      // Lide com o caso em que o user é nulo (usuário não autenticado)
      debugPrint('Erro: Usuário não autenticado');
    }

    debugPrint('userId: $userId');
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
              debugPrint(dados?.email ?? "sem dados");
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
                            onPressed: () {
                              AuthService().sigoutFirebaseAuth();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
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
                          PopupMenuButton(
                            onSelected: (value) async {
                              await AuthService().sigoutFirebaseAuth();
                              await AuthService().preferencesRemove();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            icon: const Icon(
                              size: 30,
                              Icons.account_circle,
                              color: Colors.white,
                            ),
                            itemBuilder: (context) {
                              return list.map((e) {
                                return PopupMenuItem(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(e.toString()),
                                        const Icon(
                                          Icons.logout,
                                          color: Colors.black,
                                        )
                                      ],
                                    ));
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                child2: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'Disciplinas',
                              style: CustomTextStyle.headlineSmallWhiteA700,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'Essas são as disciplinas que você ministra',
                              style: CustomTextStyle.bodySmall,
                            ),
                          ),
                          const SizedBox(height: 28),
                          FutureListDisciplina(listDisciplina: listaDisciplina)
                        ],
                      ),
                    ],
                  ),
                ),
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
