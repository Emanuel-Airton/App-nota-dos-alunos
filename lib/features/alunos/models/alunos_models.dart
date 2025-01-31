import 'package:flutter_app/models/model_notas.dart';

class Alunos {
  late String? nomeAluno;
  late String documentAluno;
  late List<Notas>? notas;

  Alunos({this.nomeAluno, required this.documentAluno, this.notas});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> notasPorTrimestre = {};

    for (var nota in notas!) {
      notasPorTrimestre = {
        "disciplina": nota.disciplina.nomeDisciplina,
        "nota": nota.nota,
      };
    }
    return notasPorTrimestre;
  }
}
