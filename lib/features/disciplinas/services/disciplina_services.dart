import 'package:flutter/material.dart';

class DisciplinaServices {
  List<Map<String, dynamic>> listaMap(Map<String, dynamic> mapTurma) {
    List<Map<String, dynamic>> _list = [];
    for (var item in mapTurma["turmas"]) {
      _list.add(item);
      for (var element in _list) {
        debugPrint(element.toString());
      }
    }
    return _list;
  }
}
