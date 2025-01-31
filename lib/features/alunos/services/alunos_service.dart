import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/models/alunos_models.dart';
import 'package:flutter_app/features/alunos/database/alunos_firestore_service.dart';
import 'package:flutter_app/features/alunos/provider/notas_firebase_provider.dart';
import 'package:flutter_app/features/disciplinas/models/disciplina_model.dart';
import 'package:flutter_app/models/model_notas.dart';

class AlunosServices {
  final List<VoidCallback> listeners = [];

//metodo que recebe o texto do controlador, permite a escrita somente de numeros e formata a pontuação
  controlleraddlistener(TextEditingController controller) {
    String text = controller.text;
    text = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 1) {
      text =
          '${text.substring(0, text.length - 1)}.${text.substring(text.length - 1)}';
    }
    controller.value = TextEditingValue(
        text: text, selection: TextSelection.collapsed(offset: text.length));
  }

  addListenerController() {
    List<TextEditingController> controllers = [];
    for (int i = 0; i < 15; i++) {
      TextEditingController controller = TextEditingController();
      listener() {
        controlleraddlistener(controller);
      }

      controller.addListener(listener);
      controllers.add(controller);
      listeners.add(listener);
    }
    return controllers;
  }

  removelistener(List<TextEditingController> controllers) {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].removeListener(listeners[i]);
      controllers[i].dispose();
    }
    return controllers;
  }

//calcula a média entre as duas avaliaçãoes do trimestre
  double calcularMedia(controllerAvaliacao1, double avaliacao2) {
    double avaliacao1 = double.parse(controllerAvaliacao1.text);
    double media = (avaliacao1 + avaliacao2) / 2;
    return media;
  }

  //Método que a nota do respectivo aluno
  salvarNota(Alunos aluno, String nomeTurma) async {
    await AlunosFirestoreService().adicionaNotaAluno(aluno, nomeTurma);
  }

//Recebe os dados referentes ao aluno, turma, e nota para salvar essa nota posteriormente
  salvar(String nomeDisciplina, String trimestre, double media,
      String documentAluno, String nomeTurma) async {
    Disciplina disciplina = Disciplina();
    Notas notas = Notas();
    disciplina.nomeDisciplina = nomeDisciplina;
    notas.trimestre = trimestre;
    notas.nota = media;
    notas.disciplina = disciplina;
    Alunos aluno = Alunos(documentAluno: documentAluno, notas: [notas]);
    await salvarNota(aluno, nomeTurma);
  }

  //recebe a lista de medias do aluno e salva no provider
  mapNotaSalva(String disciplina, AlunosfirestoreProvider provider,
      Map<String, dynamic> map) {
    List<Map> list = [];
    Map<String, dynamic> mapRecebeNotas = {};
    if (map.containsKey('notas')) {
      Map<String, dynamic> mapMediafinal = map['notas']['Média final'] ?? {};
      Map<String, dynamic> mapaNotas = map['notas'];
      // debugPrint('ma notas1: ${mapMediafinal.toString()}');
      if (mapaNotas['Média final'] != null) {
        mapaNotas.remove('Média final');
      }

      mapaNotas.forEach((key, value) {
        for (Map mapa in value) {
          if (mapa.containsValue(disciplina)) {
            mapaNotas = {
              key: {'disciplina': mapa['disciplina'], 'nota': mapa['nota']}
            };
            // debugPrint('map valor: ${mapaNotas.toString()}');
            mapRecebeNotas.addAll(mapaNotas);
            list.add(mapaNotas);
          }
        }
      });
      list.sort((a, b) => a.toString().compareTo(b.toString()));
      //  debugPrint('ma notas2: ${map['notas'].toString()}');
      if (mapMediafinal.isNotEmpty) {
        // debugPrint('map media final: $mapMediafinal');

        mapMediafinal.forEach((key, value) {
          if (key == disciplina) {
            list.add({key: value});
            mapRecebeNotas.addAll({'Média final': mapMediafinal});
          }
        });
      }

      //  debugPrint('lista valor: ${list.toString()}');
      debugPrint('map valor: ${mapRecebeNotas.toString()}');

      provider.setListNotasDisciplina(List<Map>.from(list));
      provider.setNotasDisciplinas(mapRecebeNotas, disciplina);
    }
  }

  //recebe o map contendo todas as notas do aluno, verifique se uma nota já existe e atualiza a mesma
  Future<Map<String, dynamic>> inserirNotas(
      DocumentSnapshot documentSnapshot, Notas notas, Alunos alunoNota) async {
    debugPrint('alunoNota: ${alunoNota.toMap().toString()}');
    Map<String, dynamic>? dadosAtuais =
        documentSnapshot.data() as Map<String, dynamic>?;
    Map<String, dynamic> notasAtuais = dadosAtuais?['notas'];
    Map<String, dynamic> listMapVazio = {
      'notas': [],
    };

    if (notasAtuais.containsKey(notas.trimestre)) {
      Map<String, dynamic> mediaFinal =
          {'Média final': notasAtuais['Média final']} ?? {};
      //sortedMap.remove('Média final');
      notasAtuais.remove('Média final');
      notasAtuais.forEach((key, value) {
        debugPrint('Chaves do map: ${key.toString()}');
        //List list = value;

        for (int i = 0; i < value.length; i++) {
          //debugPrint(value[i].toString());
          if (value[i]['disciplina'] == notas.disciplina.nomeDisciplina) {
            //  debugPrint('value: ${value[i].toString()}');
            listMapVazio['notas'].add(value[i]);
          }
        }
      });
      if (mediaFinal.isNotEmpty) {
        listMapVazio.addAll(mediaFinal);
      }
      debugPrint('map vazio: ${listMapVazio.toString()}');

      List<dynamic> notasTrimestre = notasAtuais[notas.trimestre];
      bool notaAtualizada = false;
      for (int i = 0; i < notasTrimestre.length; i++) {
        Map<String, dynamic> notaExistente =
            notasTrimestre[i] as Map<String, dynamic>;
        //debugPrint('notas atuais: $notasAtuais ');
        if (notaExistente['disciplina'] == notas.disciplina.nomeDisciplina) {
          notaAtualizada = true;
          notaExistente['nota'] = notas.nota;
          notasTrimestre[i] = notaExistente;
          break;
        }
      }
      if (!notaAtualizada) {
        // debugPrint('alunoNota2: ${alunoNota.toMap().toString()}');
        notasAtuais[notas.trimestre].add(alunoNota.toMap());
        notasAtuais.addAll(mediaFinal);
        listMapVazio['notas'].add(alunoNota.toMap());
        debugPrint('notas atuais2: $notasAtuais');
      }
      debugPrint('map vazio2: ${listMapVazio.toString()}');
      Map<String, dynamic> mapMediaFinal =
          notasMediaFinal(alunoNota, listMapVazio, notas.disciplina);
      debugPrint('mapMediaFinal: $mapMediaFinal');
      notasAtuais.addAll({'Média final': mapMediaFinal});
    } else {
      notasAtuais[notas.trimestre] ?? {};
      notasAtuais[notas.trimestre] = [alunoNota.toMap()];
    }
    debugPrint('notas atuais3: $notasAtuais');
    return notasAtuais;
  }

  //verifica se a nota de uma disciplina está presente nos 3 trimestres e faz o calculo da media final
  notasMediaFinal(
      Alunos aluno, Map<String, dynamic> notasAtuais, Disciplina disciplina) {
    Notas notas = Notas();
    Map<String, dynamic> notasFirebase = notasAtuais;
    List<dynamic> lista = [];

    Map<String, dynamic> mediaFinal = notasFirebase['Média final'] ?? {};
    notasFirebase.remove('Média final');

    notasFirebase.forEach((chave, valor) {
      for (int i = 0; i < valor.length; i++) {
        if (valor[i]['disciplina'] == disciplina.nomeDisciplina) {
          lista.add(valor[i]['nota']);
        }
      }
    });
    // Verificar se a disciplina possui exatamente 3 avaliações
    if (lista.length == 3) {
      notas.mediaFinal = double.parse(
          (lista.reduce((value, elemento) => value + elemento) / lista.length)
              .toStringAsFixed(1));
      notas.disciplina = disciplina;
      // Obter lista de médias finais salvas
      Map<String, dynamic> mapMediaFinal = mediaFinal;

      // Verificar se a disciplina já existe
      bool disciplinaAtualizada = false;

      if (mapMediaFinal.containsKey(disciplina.nomeDisciplina)) {
        // Atualizar o mapa existente
        mapMediaFinal[disciplina.nomeDisciplina] = notas.mediaFinal;
        disciplinaAtualizada = true;
      }
      if (!disciplinaAtualizada) {
        // Adicionar novo mapa se a disciplina não existir
        mapMediaFinal.addAll(notas.toMap());
      }
      // Retornar lista atualizada de médias finais
      debugPrint('notas: $mapMediaFinal');
      return mapMediaFinal;
    }
    notasFirebase.addAll({'Média final': mediaFinal});
    debugPrint('notas retorno: ${notasFirebase.toString()}');
    return notasFirebase['Média final'] ?? {};
  }

  //atualiza a media final caso sua o aluno tenha feito recuperação final
  recuperacaoMediaFinal(
      Map<String, dynamic> map, String disciplina, double nota, Alunos aluno) {
    Map<String, dynamic> mapMediaFinal = {};
    if (map.containsKey('Média final')) {
      mapMediaFinal = map['Média final'];
      mapMediaFinal[disciplina] = nota;
    }
    debugPrint('lista atualizada: ${mapMediaFinal.toString()}');
    AlunosFirestoreService alunosFirestoreService = AlunosFirestoreService();
    alunosFirestoreService.atualizarMediafinal(
        '6º A matutino', aluno, disciplina, nota);
  }
}
