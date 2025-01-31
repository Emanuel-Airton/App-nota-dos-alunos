import 'package:flutter/material.dart';
import 'package:flutter_app/models/model_disciplina.dart';

class AlunosfirestoreProvider extends ChangeNotifier {
  //Map _map = {'valor': false, 'notaTrimestre': 0.0, 'Média final': 0.0};
  List<Map> _listNotasDisciplina = [];
  final bool _load = true;
  Map<String, dynamic> _notasDisciplinas = {};
  bool _mediaFinalExiste = false;
  bool _notaBaixa = false;

  bool get notaBaixa => _notaBaixa;

  set notaBaixa(bool value) => _notaBaixa = value;
  //double _mediaFinal = 0.0;
  get mediaFinalExiste => _mediaFinalExiste;

  set mediaFinalExiste(value) => _mediaFinalExiste = value;

  List<Map> get listNotasDisciplina => _listNotasDisciplina;

  setListNotasDisciplina(List<Map> list) {
    _listNotasDisciplina = list;
    notifyListeners();
  }

  limparLista() {
    _listNotasDisciplina.clear();
    mediaFinalExiste = false;
    notifyListeners();
  }

  Map<String, dynamic> get notasDisciplinas => _notasDisciplinas;

  setNotasDisciplinas(Map<String, dynamic> value, String disciplina) {
    _notasDisciplinas = value;
    verificaNotaVermelha(disciplina);
    notifyListeners();
  }

  limparMap() {
    _notasDisciplinas.clear();
    mediaFinalExiste = false;
    notaBaixa = false;
    notifyListeners();
  }

  verificaNota() {
    mediaFinalExiste = false;
    notifyListeners();
    if (notasDisciplinas.containsKey('Média final')) {
      mediaFinalExiste = true;
      notifyListeners();
    }
  }

  verificaNotaVermelha(String disciplina) {
    verificaNota();

    if (notasDisciplinas['Média final'][disciplina] < 6) {
      notaBaixa = true;
      notifyListeners();
    } else {
      notaBaixa = false;
      notifyListeners();
    }
  }

  bool get load => _load;
}
