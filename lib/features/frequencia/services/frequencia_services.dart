import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/frequencia/database/frequencia_firestore.dart';
import 'package:flutter_app/features/frequencia/models/frequencia_model.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

class FrequenciaServices {
  FrequenciaModel frequenciaModel = FrequenciaModel();
  FrequenciaFirestore frequenciaFirestore = FrequenciaFirestore();

  // adiciona a lista de alunos um novo map contendo os dias do mês atual para gerar a tabela de frequencia
  adicionarMapFrequenciaAluno(DateTime selectedDate, List<Map> listAlunos,
      String nomeDisciplina) async {
    late String dateMes;
    List<Map<String, dynamic>> diasDoMes = [];
    int numeroMesAtual = selectedDate.month; //mês atual ex: Janeiro = 1
    final diasDoMesAtual =
        DateTime(2025, numeroMesAtual + 1, 0).day; //Janeiro=31
    for (Map element in listAlunos) {
      diasDoMes = List.generate(diasDoMesAtual, (index) {
        final diaNumerico = index + 1; // dia 1, 2 ,3
        final data = DateTime(2025, numeroMesAtual, diaNumerico); //2025-01-01
        final diaSemana = DateFormat('EEEE', 'pt_BR').format(data);
        dateMes = DateFormat('MMMM', 'pt_BR').format(selectedDate);
        return {'dia': diaNumerico, 'diaDaSemana': diaSemana, 'falta': false};
      });
      element.addAll({
        'frequencia': {'mês': dateMes, 'dias': diasDoMes}
      });
    }
    listAlunos = await carregarFaltas(listAlunos, dateMes, nomeDisciplina);
  }

  //selecionar o mês ao clicar no calendario
  Future<DateTime> selecionarMesCalendario(BuildContext context,
      DateTime selectedDate, List<Map> alunos, String nomeDisciplina) async {
    final DateTime? selecionarMes = await showMonthPicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2026));
    if (selecionarMes != null && selecionarMes != selectedDate) {
      selectedDate = selecionarMes;
    }
    return selectedDate;
  }

  //Cria um novo map contendo o dia da falta individual do aluno para salvar no banco
  adicionarFaltaIndividualAluno(Map<String, dynamic> alunoFrequencia, String id,
      String mesAtual, String disciplina) async {
    if (alunoFrequencia['falta']) {
      frequenciaModel.mes = mesAtual;
      frequenciaModel.faltas = {
        'dia do mês': alunoFrequencia['dia'],
        'dia da semana': alunoFrequencia['diaDaSemana']
      };
      frequenciaModel.disciplina = disciplina;
      atualizarFrequencia(frequenciaModel, id);
    }
  }

  atualizarFrequencia(FrequenciaModel frequenciaModel, String idAluno) async {
    Map<String, dynamic> mapAtualizar = formatarDados(frequenciaModel);
    await frequenciaFirestore.updateFrequenciaFirestore(mapAtualizar, idAluno);
  }

  //formata o map no modelo esperado pelo Firestore, usando o FieldValue.arrayUnion para evitar duplicações ao adicionar ao array
  Map<String, dynamic> formatarDados(FrequenciaModel frequenciaModel) {
    return {
      'frequencia.${frequenciaModel.mes}.${frequenciaModel.disciplina}.faltas':
          FieldValue.arrayUnion([frequenciaModel.faltas])
    };
  }

  Future<List<Map<dynamic, dynamic>>> carregarFaltas(
      List<Map> listAlunos, String mesAtual, String nomeDisciplina) async {
    for (var aluno in listAlunos) {
      // Caminho do documento do aluno
      final alunoDoc = frequenciaFirestore.docRefDadosAluno(aluno['id']);
      // Buscando os dados do aluno
      final snapshot = await alunoDoc.get();
      Map<String, dynamic> alunoData = snapshot.data() as Map<String, dynamic>;
      if (alunoData.containsKey('frequencia')) {
        // Acessa o campo de frequência do mês atual
        final frequencia =
            alunoData['frequencia']?[mesAtual][nomeDisciplina] ?? [];
        if (frequencia != null && frequencia['faltas'] != null) {
          final diasFaltosos = frequencia['faltas'];
          for (var falta in diasFaltosos) {
            final diaFaltoso = aluno['frequencia']['dias'].firstWhere(
              (dia) => dia['dia'] == falta['dia do mês'],
            );
            if (diaFaltoso != null) {
              diaFaltoso['falta'] = true; // Marca o dia como falta
            }
          }
        }
      }
    }
    debugPrint('lista de alunos: ${listAlunos.toString()}');

    return listAlunos;
  }
}
