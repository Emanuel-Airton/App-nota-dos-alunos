import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlunosNotasProvider extends ChangeNotifier {
  /* double _valorPrimeiraAvaliacao = 0.0;
  double _nota1 = 0.0;
  double _nota2 = 0.0;
  double _nota3 = 0.0;
  double _valorSegundaAvaliacao = 0.0;
  double _media = 0.0;
  String _mensagemErro = '';

  double get valorPrimeiraAvaliacao => _valorPrimeiraAvaliacao;

  set valorPrimeiraAvaliacao(double value) {
    _valorPrimeiraAvaliacao = value;
    calcMedia();
    notifyListeners();
  }

  set nota1(double nota1) {
    if (nota1 > 10.0) {
      _atualizaMensagem();
    } else {
      _mensagemErro = ''; // Limpa a mensagem de erro se o valor for válido
      _nota1 = nota1;
      _atualizarValorSegundaAvaliacao();
    }
    notifyListeners();
  }

  double get nota1 => _nota1;

  set nota2(double nota2) {
    if (nota2 > 10.0) {
      _atualizaMensagem();
    } else {
      _mensagemErro = ''; // Limpa a mensagem de erro se o valor for válido
      _nota2 = nota2;
      _atualizarValorSegundaAvaliacao();
    }
    notifyListeners();
  }

  double get nota2 => _nota2;

  set nota3(double nota3) {
    if (nota3 > 10.0) {
      _atualizaMensagem();
    } else {
      _mensagemErro = ''; // Limpa a mensagem de erro se o valor for válido
      _nota3 = nota3;
      _atualizarValorSegundaAvaliacao();
    }
    notifyListeners();
  }

  double get nota3 => _nota3;
  void _atualizarValorSegundaAvaliacao() {
    valorSegundaAvaliacao = nota1 + nota2 + nota3;
    notifyListeners();
  }

  double get valorSegundaAvaliacao => _valorSegundaAvaliacao;
  set valorSegundaAvaliacao(double valor) {
    if (valor > 10.0) {
      _atualizaMensagem();
    } else {
      _valorSegundaAvaliacao = valor;
      _mensagemErro = '';
      calcMedia();
    }
    notifyListeners();
  }

  _atualizaMensagem() {
    _mensagemErro = 'O nota não pode ser maior que 10.0';
  }

  double get media => _media;

  calcMedia() {
    _media = (valorPrimeiraAvaliacao + valorSegundaAvaliacao) / 2;
    if (_media > 10.0) {
      _atualizaMensagem();
    }
    notifyListeners();
  }

  void resetarValores() {
    nota1 = 0.0;
    nota2 = 0.0;
    nota3 = 0.0;
    valorSegundaAvaliacao = 0.0;
    valorPrimeiraAvaliacao = 0.0;
    _atualizarValorSegundaAvaliacao();
    calcMedia();
    notifyListeners();
  }

  String get mensagemErro => _mensagemErro;*/
  static const primeiroTrimestre = 'I trimestre';
  static const segundoTrimestre = 'II trimestre';
  static const terceiroTrimestre = 'III trimestre';
  static const primeiraAvaliacao = 'primeira avaliação';
  static const segundaAvaliacao = 'segunda avaliação';
  static const mediaFinal = 'média final';

  final Map<String, List> _notasTrimestre = {
    primeiroTrimestre: <dynamic>[
      {primeiraAvaliacao: 0.0},
      <String, List<double>>{
        segundaAvaliacao: [0.0, 0.0, 0.0]
      }
    ],
    segundoTrimestre: [
      {primeiraAvaliacao: 0.0},
      <String, List<double>>{
        segundaAvaliacao: [0.0, 0.0, 0.0]
      }
    ],
    terceiroTrimestre: [
      {primeiraAvaliacao: 0.0},
      <String, List<double>>{
        segundaAvaliacao: [0.0, 0.0, 0.0]
      }
    ],
    mediaFinal: [0.0]
  };
  final Map<String, double> _media = {
    primeiroTrimestre: 0.0,
    segundoTrimestre: 0.0,
    terceiroTrimestre: 0.0
  };

  final Map<String, double> _notaSegundaAvaliacao = {
    primeiroTrimestre: 0.0,
    segundoTrimestre: 0.0,
    terceiroTrimestre: 0.0
  };
  final Map<String, double> notaRecuperacaoParalela = {
    primeiroTrimestre: 0.0,
    segundoTrimestre: 0.0,
    terceiroTrimestre: 0.0
  };
  String _mensagemErro = '';

  atualizaMensagem(double nota) {
    if (nota > 10.0) {
      _mensagemErro = 'A nota não pode ser maior que 10.0';
    } else {
      _mensagemErro = '';
    }
    notifyListeners();
  }

  double getNotaPrimeiraAvaliacao(String trimestre, int avaliacao) {
    return _notasTrimestre[trimestre]?[avaliacao] ?? 0.0;
  }

  //Insere a nota da primeira avaliação
  void setNotaPrimeiraAvaliacao(String trimestre, int avaliacao, dynamic nota) {
    _notasTrimestre[trimestre]?[avaliacao] = nota;
    calcularMediaTrimestre(trimestre);
    atualizaMensagem(nota);
    notifyListeners();
  }

  get notaSegundaAvaliacao => _notaSegundaAvaliacao;
  //recebe tres notas que formam a segunda nota do trimestre
  setNotaSegundaAvaliacao(String trimestre, int avaliacao, double nota) {
    _notasTrimestre[trimestre]?[1][segundaAvaliacao][avaliacao] = nota;
    double n1 = _notasTrimestre[trimestre]?[1][segundaAvaliacao][0];
    double n2 = _notasTrimestre[trimestre]?[1][segundaAvaliacao][1];
    double n3 = _notasTrimestre[trimestre]?[1][segundaAvaliacao][2];
    List<double> segundaNota = [n1, n2, n3];
    double somaSegundaNota =
        segundaNota.reduce((acumulator, element) => acumulator + element);
    _notaSegundaAvaliacao[trimestre] = somaSegundaNota;
    notifyListeners();
    calcularMediaTrimestre(trimestre);
    atualizaMensagem(_notaSegundaAvaliacao[trimestre]!);
  }

  String get mensagemErro => _mensagemErro;
  //calcula a media do trimestre
  calcularMediaTrimestre(String trimestre) {
    if (notaRecuperacaoParalela[trimestre] != 0.0) {
      _media[trimestre] = notaRecuperacaoParalela[trimestre] ?? 0.0;
    } else {
      final double notas1 = _notasTrimestre[trimestre]?[0] ?? 0.0;
      final notas2 = notaSegundaAvaliacao[trimestre] ?? 0.0;
      _media[trimestre] = (notas1 + notas2) / 2;
    }
    notifyListeners();
    atualizaMensagem(media[trimestre]);
    setMediaFinal();
  }

  get media => _media;

  double getMediaTrimestre(String trimestre) {
    return _media[trimestre] ?? 0.0;
  }

  setMediaFinal() {
    List notas = [];
    media.forEach((key, value) {
      notas.add(value);
    });
    _notasTrimestre[mediaFinal]?[0] =
        notas.reduce((value, element) => value + element) / 3;
    notifyListeners();
  }

  double getMediaFinal() {
    return _notasTrimestre[mediaFinal]?[0] ?? 0.0;
  }

  setNotaRecuperacaoParalela(double nota, String trimestre) {
    notaRecuperacaoParalela[trimestre] = nota;
    calcularMediaTrimestre(trimestre);
    atualizaMensagem(nota);
    notifyListeners();
  }

  double getNotaRecuperacaoParalela(String trimestre) {
    return notaRecuperacaoParalela[trimestre] ?? 0.0;
  }

  void resetarTrimestre(String trimestre) {
    _notasTrimestre[trimestre]?[0] = 0.0;
    _notasTrimestre[trimestre]?[1][segundaAvaliacao] = [0.0, 0.0, 0.0];
    _notaSegundaAvaliacao[trimestre] = 0.0;
    _media[trimestre] = 0.0;
    atualizaMensagem(_media[trimestre]!);
    notifyListeners();
  }

  void resetarTodosTrimestres() {
    for (String trimestre in _notasTrimestre.keys) {
      if (!trimestre.contains(mediaFinal)) {
        resetarTrimestre(trimestre);
      }
    }
  }
}
