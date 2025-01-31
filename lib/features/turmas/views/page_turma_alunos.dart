import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/turmas/services/turmas_firestore_service.dart';
import 'package:flutter_app/features/turmas/widgets/container_turmas.dart';
import 'package:flutter_app/features/turmas/widgets/futureBuilder_data_aluno.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';

// ignore: must_be_immutable
class PageTurmaAlunos extends StatefulWidget {
  late String turma;
  late Disciplina nomeDisciplina;
  //Disciplina disciplina;
  PageTurmaAlunos(
      {super.key, required this.turma, required this.nomeDisciplina});

  @override
  State<PageTurmaAlunos> createState() => _PageTurmaState();
}

class _PageTurmaState extends State<PageTurmaAlunos> {
  late Future<Map> map;
  late int quantidade = 0;
  @override
  void initState() {
    super.initState();

    returnList();
    debugPrint('turma ${widget.turma}');
  }

  returnList() async {
    //debugPrint("turma: ${widget.turma}");
    map = TurmasFirestoreService().listarTurmasFirestore(widget.turma);
    map.then((value) {
      setState(() {
        //  debugPrint('value map: ${value.toString()}');
        quantidade = value["quantidade"];
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("Dependências mudaram em PageTurma");
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('rebuild PageTurma');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 30, 30, 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          )),
                      Text('Turma/alunos', style: CustomTextStyle.fontInfoTop),
                    ],
                  ),
                ),
                Flexible(
                  child: Stack(
                    children: [
                      CustomBackgroundLayout(
                        heightContainer: 0.75,
                        child1: Container(),
                        child2: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: FutureBuilderDataAluno(
                              map: map,
                              nomeDisciplina: widget.nomeDisciplina,
                              nomeTurma: widget.turma,
                            ),
                          ),
                        ),
                        child3: Container(),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: ContainerTurmas(
                            turma: widget.turma,
                            quantidade: quantidade,
                            ontapImage: () {},
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
