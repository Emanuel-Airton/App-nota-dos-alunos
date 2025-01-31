import 'package:flutter/material.dart';
import 'package:flutter_app/features/disciplinas/models/disciplina_model.dart';
import 'package:flutter_app/features/frequencia/services/frequencia_services.dart';
import 'package:flutter_app/features/turmas/services/turmas_firestore_service.dart';
import 'package:intl/intl.dart';

class FrequenciaProvider extends ChangeNotifier {
  final FrequenciaServices frequenciaServices = FrequenciaServices();
  final TurmasFirestoreService turmasFirestoreService =
      TurmasFirestoreService();
  List<Map> alunos = [];
  DateTime selectedDate = DateTime.now();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _mes = '';
  String get mes => _mes;
  set mes(mes) => _mes = mes;

  final Disciplina _disciplina = Disciplina();
  get disciplina => _disciplina.nomeDisciplina;
  set disciplina(value) => _disciplina.nomeDisciplina = value;

  Future<void> initData(List<Map> listAlunosInserida) async {
    _isLoading = true;
    _mes = DateFormat('MMMM', 'pt_BR').format(selectedDate);
    notifyListeners();
    try {
      alunos = listAlunosInserida;
      await frequenciaServices.adicionarMapFrequenciaAluno(
          selectedDate, alunos, disciplina);
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao carregar os dados: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<DateTime> selecionarMes(BuildContext context) async {
    try {
      selectedDate = await frequenciaServices.selecionarMesCalendario(
          context, selectedDate, alunos, disciplina);
      await selectDateProvider();
      notifyListeners();
    } catch (e) {
      debugPrint("Erro: $e");
    }
    return selectedDate;
  }

  selectDateProvider() async {
    _mes = DateFormat('MMMM', 'pt_BR').format(selectedDate);
    debugPrint('mes atual: $mes');
    _isLoading = true;
    notifyListeners();
    try {
      await frequenciaServices.adicionarMapFrequenciaAluno(
          selectedDate, alunos, disciplina);
      notifyListeners();
    } catch (e) {
      debugPrint("Erro: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /* mesSelecionado(int index) {
    _mes = alunos[index]['frequencia']['mês'].toString();
    notifyListeners();
  }*/

  recebeValorFaltaAluno(int indexAluno, int indexAlunoFrequencia) {
    alunos[indexAluno]['frequencia']['dias'][indexAlunoFrequencia]['falta'] =
        !alunos[indexAluno]['frequencia']['dias'][indexAlunoFrequencia]
            ['falta'];
    adicionarFaltaMap(indexAluno, indexAlunoFrequencia);
    notifyListeners();
  }

  adicionarFaltaMap(int indexAluno, int indexAlunoFrequencia) {
    frequenciaServices.adicionarFaltaIndividualAluno(
        alunos[indexAluno]['frequencia']['dias'][indexAlunoFrequencia],
        alunos[indexAluno]['id'],
        mes,
        disciplina);
  }
}
