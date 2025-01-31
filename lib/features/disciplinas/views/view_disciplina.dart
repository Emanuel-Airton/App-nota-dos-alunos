import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/disciplinas/services/disciplina_services.dart';
import 'package:flutter_app/features/disciplinas/widgets/container_nome_disciplina.dart';
import 'package:flutter_app/features/disciplinas/widgets/container_nome_turma_disciplina.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PageDisciplina extends StatefulWidget {
  late Map<String, dynamic> mapTurma;

  PageDisciplina({super.key, required this.mapTurma});

  @override
  State<PageDisciplina> createState() => _PageDisciplinaState();
}

class _PageDisciplinaState extends State<PageDisciplina> {
  List<Map<String, dynamic>> listDisciplinas = [];
  Disciplina disciplina = Disciplina();

  @override
  void initState() {
    // TODO: implement initState
    debugPrint(widget.mapTurma.toString());
    listDisciplinas = DisciplinaServices().listaMap(widget.mapTurma);
    disciplina.nomeDisciplina = widget.mapTurma["nome"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: SizedBox(
          width: double.infinity,
          child: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 75),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                )),
                            Text(
                              'Disciplina/turmas',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Stack(
                        children: [
                          CustomBackgroundLayout(
                            child1: Container(),
                            child2: SizedBox(
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: listDisciplinas.length,
                                      itemBuilder: (context, index) {
                                        var nomeTurma =
                                            listDisciplinas[index]["nomeTurma"];
                                        return Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 10),
                                          child: ContainerDisciplinaNomeTurma(
                                            nomeTurma: nomeTurma,
                                            nomeDisciplina: disciplina,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child3: Container(),
                            heightContainer: 0.75,
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: ContainerNomeDisciplina(
                                    nomeDisciplina: disciplina.nomeDisciplina),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
