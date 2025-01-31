import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/features/frequencia/models/frequencia_model.dart';

class FrequenciaFirestore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static const colecaoTurma = 'turmas';
  static const colecaoAlunos = 'alunos';

  DocumentReference<Object?> docRefDadosAluno(String idAluno) {
    final DocumentReference docRef = _firebaseFirestore
        .collection(colecaoTurma)
        .doc('6º A matutino')
        .collection(colecaoAlunos)
        .doc(idAluno);
    return docRef;
  }

  adicionarFaltaAluno(FrequenciaModel frequenciaModel, String idAluno) {
    try {
      DocumentReference documentReference = docRefDadosAluno(idAluno);
      documentReference
          .set(frequenciaModel.tolist(), SetOptions(merge: true))
          .then((value) => print('valor inserido'));
    } on FirebaseException catch (e) {
      print('Erro: ${e.code}');
    }
  }

  updateFrequenciaFirestore(
      Map<String, dynamic> atualizar, String idAluno) async {
    try {
      DocumentReference documentReference = docRefDadosAluno(idAluno);
      await documentReference
          .update(atualizar)
          .then((value) => print('valor atualizado'));
    } on FirebaseException catch (e) {
      print('Erro: ${e.code}');
    }
  }
}
