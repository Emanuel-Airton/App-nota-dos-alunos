import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/provider/alunos_notas_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ContainerSegundaAvaliacao extends StatefulWidget {
  late String trimestre;
  ContainerSegundaAvaliacao({super.key, required this.trimestre});

  @override
  State<ContainerSegundaAvaliacao> createState() =>
      _ContainerSegundaAvaliacaoState();
}

class _ContainerSegundaAvaliacaoState extends State<ContainerSegundaAvaliacao> {
  @override
  Widget build(BuildContext context) {
    final alunosProvider =
        Provider.of<AlunosNotasProvider>(context, listen: true);
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey.shade500,
            ),
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
                //  '2º Avaliação: ${alunosProvider.valorSegundaAvaliacao.toStringAsFixed(1)}'
                'Segunda Avaliação: ${alunosProvider.notaSegundaAvaliacao[widget.trimestre].toStringAsFixed(1)}'),
          ),
        ));
  }
}
