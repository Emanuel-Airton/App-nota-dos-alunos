import 'package:flutter/material.dart';
import 'package:flutter_app/features/frequencia/provider/frequencia_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ContainerFrequencia extends StatefulWidget {
  late bool value;
  late int indexAluno;
  late int indexValorFrequencia;
  ContainerFrequencia(
      {super.key,
      required this.value,
      required this.indexAluno,
      required this.indexValorFrequencia});

  @override
  State<ContainerFrequencia> createState() => _ContainerFrequenciaState();
}

class _ContainerFrequenciaState extends State<ContainerFrequencia> {
  @override
  Widget build(BuildContext context) {
    final frequenciaProvider = Provider.of<FrequenciaProvider>(context);
    return GestureDetector(
      onTap: () {
        widget.value = !widget.value;
        frequenciaProvider.recebeValorFaltaAluno(
            widget.indexAluno, widget.indexValorFrequencia);
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: !widget.value ? null : Colors.red),
        child: Center(
            child: Text(
          !widget.value ? '' : 'F',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
