import 'package:flutter_app/features/turmas/models/turmas_models.dart';

class Disciplina {
  late String _nomeDisciplina;
  late String _turno;
  late List<Turmas> turmas;

  get nomeDisciplina => _nomeDisciplina;

  set nomeDisciplina(value) => _nomeDisciplina = value;

  get turno => _turno;

  set turno(value) => _turno = value;

  Map<String, dynamic> toMap(List<Turmas> turmas) {
    return {
      "nome": nomeDisciplina,
      "turmas": turmas
          .map((turma) => {"nomeTurma": turma.nomeTuma, "turno": turma.turno}),
    };
  }
}
