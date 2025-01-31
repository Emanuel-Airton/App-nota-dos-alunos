import 'package:flutter_app/models/model_disciplina.dart';

class FrequenciaModel {
  late String _mes;
  late final Disciplina _disciplina = Disciplina();
  late Map<String, dynamic> _faltas;
  late List listFaltas;

  get mes => _mes;

  set mes(value) => _mes = value;

  get faltas => _faltas;

  set faltas(value) => _faltas = value;

  get disciplina => _disciplina.nomeDisciplina;

  set disciplina(value) => _disciplina.nomeDisciplina = value;

  Map<String, dynamic> toMap() {
    return {
      mes: {
        'faltas': [faltas]
      }
    };
  }

  Map<String, dynamic> tolist() {
    return {'Frequencia': listFaltas};
  }

  //'frequencia.fevereiro.${frequenciaModel.disciplina}.faltas'
  Map<String, dynamic> toMapFalta() {
    return {
      'frequencia': {
        mes: {
          disciplina: {
            'faltas': [faltas]
          }
        }
      }
    };
  }
}
