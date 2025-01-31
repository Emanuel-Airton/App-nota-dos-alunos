import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/models/alunos_models.dart';
import 'package:flutter_app/features/alunos/database/alunos_firestore_service.dart';
import 'package:flutter_app/features/alunos/provider/notas_firebase_provider.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ContainerCheckNota extends StatefulWidget {
  Alunos aluno;
  late String nomeTurma;
  late String trimestrevalor;
  late Disciplina disciplina;
  ContainerCheckNota(
      {super.key,
      required this.disciplina,
      required this.trimestrevalor,
      required this.aluno,
      required this.nomeTurma});

  @override
  State<ContainerCheckNota> createState() => _ContainerCheckNotaState();
}

class _ContainerCheckNotaState extends State<ContainerCheckNota> {
  late AlunosFirestoreService alunosFirestoreService;
  int indice = 0;
  @override
  void initState() {
    switch (widget.trimestrevalor) {
      case 'II trimestre':
        indice = 1;
        break;
      case 'III trimestre':
        indice = 2;
        break;
      default:
        indice = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alunosProvider =
        Provider.of<AlunosfirestoreProvider>(context, listen: true);
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.center,
        child: indice < alunosProvider.listNotasDisciplina.length &&
                alunosProvider.listNotasDisciplina[indice]
                    .containsKey(widget.trimestrevalor)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.check_circle, color: Colors.blue),
                  Text(
                    'Média do trimestre: ${alunosProvider.listNotasDisciplina[indice][widget.trimestrevalor]['nota'].toString()}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.blue),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.pending,
                      color: Theme.of(context).colorScheme.primary),
                  Text(
                    'Nota pendente',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  )
                ],
              ));
  }
}
