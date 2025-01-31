import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/models/alunos_models.dart';
import 'package:flutter_app/features/alunos/provider/notas_firebase_provider.dart';
import 'package:flutter_app/features/alunos/services/alunos_service.dart';
import 'package:flutter_app/models/model_notas.dart';

class AlunosFirestoreService {
  ValueNotifier<Map> mapValueNotifier =
      ValueNotifier({'valor': false, 'notaTrimestre': 0.0, 'Média final': 0.0});

  ValueNotifier<bool> valor = ValueNotifier(false);
  //ValueNotifier<double> notaTrimestre = ValueNotifier(0.0);
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final colecaoAlunos = 'alunos';
  final colecaoTurmas = 'turmas';

  adicionaNotaAluno(Alunos alunoNota, String nomeTurma) async {
    AlunosServices alunosServices = AlunosServices();

    Notas notas = Notas();
    alunoNota.notas!.forEach((element) {
      notas.disciplina = element.disciplina;
      notas.nota = element.nota;
      notas.trimestre = element.trimestre;
      // debugPrint('notas do aluno: ${notas.nota}');
    });
    final docRef = _firebaseFirestore
        .collection(colecaoTurmas)
        .doc(nomeTurma)
        .collection(colecaoAlunos)
        .doc(alunoNota.documentAluno);

    try {
      DocumentSnapshot documentSnapshot = await docRef.get();
      Map<String, dynamic> notasAtuais =
          await alunosServices.inserirNotas(documentSnapshot, notas, alunoNota);
      //  debugPrint('notas do trimestre: $notasAtuais');
      await docRef.update({'notas': notasAtuais});
      debugPrint("Notas atualizadas com sucesso");
    } on FirebaseException catch (e) {
      debugPrint("Failed with error '${e.code}': ${e.message}");
      rethrow;
    }
  }

  atualizarMediafinal(
      String nomeTurma, Alunos aluno, String disciplina, double nota) async {
    try {
      await _firebaseFirestore
          .collection(colecaoTurmas)
          .doc(nomeTurma)
          .collection(colecaoAlunos)
          .doc(aluno.documentAluno)
          .update({'notas.Média final.$disciplina': nota});
    } on FirebaseException catch (e) {
      debugPrint("Failed with error '${e.code}': ${e.message}");
    }
  }

  //metodo que verifica em tempo real se o aluno tem a nota salva ou está pendente
  streamNotas(String doc, String nomeTurma, String disciplina,
      AlunosfirestoreProvider provider) {
    AlunosServices alunosServices = AlunosServices();
    Map<String, dynamic> map = {};
    _firebaseFirestore
        .collection('turmas')
        .doc(nomeTurma)
        .collection('alunos')
        .doc(doc)
        .snapshots()
        .listen((event) {
      map.addAll(event.data() as Map<String, dynamic>);
      alunosServices.mapNotaSalva(disciplina, provider, map);
    });
    //  return list;
  }
}
