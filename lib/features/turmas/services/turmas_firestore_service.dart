import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TurmasFirestoreService {
  static const String colecaoAlunos = "alunos";
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<Map> listarTurmasFirestore(String turma) async {
    List<Map> listAlunosTurma = [];
    // String documentID = "";
    Map<String, dynamic> mapTurma = {};
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("turmas")
          .doc(turma)
          .collection(colecaoAlunos)
          .get();
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> mapAlunos =
            documentSnapshot.data() as Map<String, dynamic>;

        Map map = {
          "nome": mapAlunos["nome"],
          "id": documentSnapshot.id,
        };
        listAlunosTurma.add(map);
      }
      mapTurma = {
        "quantidade": listAlunosTurma.length,
        "alunos": listAlunosTurma
      };

      listAlunosTurma.sort(
        (a, b) {
          String nomeA = a["nome"];
          String nomeB = b["nome"];
          return nomeA.compareTo(nomeB);
        },
      );
      //  debugPrint(listTurmas.length.toString());
    } catch (e) {
      debugPrint("ocorreu um erro: $e");
    }
    return mapTurma;
  }
}
