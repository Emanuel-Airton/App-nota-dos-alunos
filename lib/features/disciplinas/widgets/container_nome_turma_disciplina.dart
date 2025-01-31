import 'package:flutter/material.dart';
import 'package:flutter_app/features/turmas/views/page_turma.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ContainerDisciplinaNomeTurma extends StatelessWidget {
  late String nomeTurma;
  late Disciplina nomeDisciplina;
  ContainerDisciplinaNomeTurma(
      {super.key, required this.nomeTurma, required this.nomeDisciplina});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
              ],
              color: const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFFEFEFEF))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageTurma(
                                    turma: nomeTurma,
                                    disciplina: nomeDisciplina,
                                  )));
                      //TurmasFirestoreService().listarTurmasFirestore();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(18, 19, 14, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/lecture_12.png',
                                  ),
                                ),
                              ),
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 3, 26.3, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(nomeTurma,
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: const Color(0xFFED6969),
                                      )),
                                  Text(
                                    '35 alunos',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      height: 1.3,
                                      color: const Color(0xFFED6969),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
