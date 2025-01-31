import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/disciplinas/models/disciplina_model.dart';
import 'package:flutter_app/features/turmas/models/turmas_models.dart';

class DisciplinaFirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Disciplina>> listarDisciplinaProfessor(String id) async {
    List<Disciplina> listaDisciplina = [];
    try {
      DocumentSnapshot documentSnapshot =
          await _firebaseFirestore.collection("professores").doc(id).get();
      Map<String, dynamic> map =
          documentSnapshot.data() as Map<String, dynamic>;
      List list = map["disciplina"];

      for (Map item in list) {
        Disciplina disciplina = Disciplina();

        disciplina.turmas = [];
        disciplina.nomeDisciplina = item["nome"];
        List listaTurmas = item["turmas"];

        listaTurmas.forEach((element) {
          Turmas turmas = Turmas();
          turmas.nomeTuma = element["nome"];
          turmas.turno = element["turno"];
          disciplina.turmas.add(turmas);
          debugPrint("nome da disciplina: ${disciplina.nomeDisciplina}");
          disciplina.turmas.forEach((element) {
            debugPrint("Nome turma: ${element.nomeTuma}");
          });
        });
        listaDisciplina.add(disciplina);
      }
    } catch (e) {
      debugPrint('erro $e');
    }
    return listaDisciplina;
  }
}
