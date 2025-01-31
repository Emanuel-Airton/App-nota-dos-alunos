import 'package:flutter/material.dart';
import 'package:flutter_app/features/frequencia/provider/frequencia_provider.dart';
import 'package:flutter_app/features/turmas/services/turmas_firestore_service.dart';
import 'package:flutter_app/features/turmas/views/page_turma_alunos.dart';
import 'package:flutter_app/features/turmas/widgets/container_escolha.dart';
import 'package:flutter_app/features/turmas/widgets/container_turmas.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageTurma extends StatefulWidget {
  late String turma;
  late Disciplina disciplina;
  //Disciplina disciplina;
  PageTurma({super.key, required this.turma, required this.disciplina});

  @override
  State<PageTurma> createState() => _PageTurmaState();
}

class _PageTurmaState extends State<PageTurma> {
  late Future<Map> map;
  late int quantidade = 0;
  late List<Map> listAlunos;
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
        listAlunos = value['alunos'];
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("Dependências mudaram em PageTurma");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('dispose');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FrequenciaProvider>(context);
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
                            Text(
                              'Turma/alunos',
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
                            heightContainer: 0.75,
                            child1: Container(),
                            child2: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ContainerEscolha(
                                    texto: 'Frequencia',
                                    onTap: () {
                                      provider.disciplina =
                                          widget.disciplina.nomeDisciplina;
                                      provider.initData(listAlunos);
                                      // debugPrint('alunos: ${provider.alunos}');
                                      Navigator.push(
                                          context,
                                          Routes().generateRoutes(
                                              const RouteSettings(
                                                  name: 'frequencia')));
                                    },
                                  ),
                                  ContainerEscolha(
                                    texto: 'Avaliações',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PageTurmaAlunos(
                                                    nomeDisciplina:
                                                        widget.disciplina,
                                                    turma: widget.turma,
                                                  )));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            child3: Container(),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30),
                                child: ContainerTurmas(
                                  turma: widget.turma,
                                  quantidade: quantidade,
                                  ontapImage: () {},
                                )),
                          ),
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
