import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/disciplinas/models/disciplina_model.dart';
import 'package:flutter_app/features/disciplinas/services/disciplina_firestore_service.dart';

class HomeServices {
  AuthService authService = AuthService();
  late Future<User?> authuser;
  String userId = "";
  late Future<List<Disciplina>> listaDisciplina;

  Future<List<Disciplina>> loadUserData() async {
    // Obtém o usuário atual e aguarda a resolução
    authuser = authService.getCurrentUser();
    final user = await authuser;

    // Garante que o usuário não seja nulo antes de acessar o 'uid'
    if (user != null) {
      userId = user.uid;
      // Agora que temos o userId, carregamos a lista de disciplinas
      listaDisciplina =
          DisciplinaFirestoreService().listarDisciplinaProfessor(userId);
    } else {
      // Lide com o caso em que o user é nulo (usuário não autenticado)
      debugPrint('Erro: Usuário não autenticado');
    }

    debugPrint('userId: $userId');

    return listaDisciplina;
  }
}
