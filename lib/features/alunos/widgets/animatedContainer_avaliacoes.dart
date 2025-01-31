import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/models/alunos_models.dart';
import 'package:flutter_app/features/alunos/provider/alunos_notas_provider.dart';
import 'package:flutter_app/features/alunos/widgets/buttom_nota_saved.dart';
import 'package:flutter_app/features/alunos/widgets/container_check_nota.dart';
import 'package:flutter_app/features/alunos/widgets/container_input_nota.dart';
import 'package:flutter_app/features/alunos/widgets/container_media.dart';
import 'package:flutter_app/features/alunos/widgets/container_segunda_avaliacao.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AnimatedContainerAvaliacoes extends StatefulWidget {
  late String trimestre;
  late String trimestrevalor;
  late String nomeTurma;
  late Disciplina disciplina;
  Alunos aluno;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controllerRecuperacaoParalela = TextEditingController();
  void Function()? onpressed;
  AnimatedContainerAvaliacoes(
      {super.key,
      required this.disciplina,
      required this.aluno,
      required this.nomeTurma,
      required this.trimestrevalor,
      required this.trimestre,
      required this.controller1,
      required this.controller2,
      required this.controller3,
      required this.controller4,
      required this.controllerRecuperacaoParalela,
      required this.onpressed});

  @override
  State<AnimatedContainerAvaliacoes> createState() =>
      _AnimatedContainerAvaliacoesState();
}

class _AnimatedContainerAvaliacoesState
    extends State<AnimatedContainerAvaliacoes> {
  bool isExpanded = false;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final alunosProvider =
        Provider.of<AlunosNotasProvider>(context, listen: false);
    return AnimatedContainer(
      width: double.infinity,
      height: isExpanded ? height * 0.65 : height * 0.165,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
        ],
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.trimestre,
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: const Color(0xFF7E7E7E),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        child: Text(
                          'Disciplina: ${widget.disciplina.nomeDisciplina} ',
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: const Color(0xFF7E7E7E),
                          ),
                        ),
                      ),
                      ContainerCheckNota(
                        nomeTurma: widget.nomeTurma,
                        trimestrevalor: widget.trimestrevalor,
                        aluno: widget.aluno,
                        disciplina: widget.disciplina,
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      icon: Icon(isExpanded == false
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_up_rounded))
                ],
              ),
              if (isExpanded) ...[
                Column(
                  children: [
                    ContainerInputNota(
                      trimestre: widget.trimestrevalor,
                      onChanged: (p0) {
                        alunosProvider.setNotaPrimeiraAvaliacao(
                            widget.trimestrevalor,
                            0,
                            double.tryParse(p0) ?? 0.0);
                      },
                      color: const Color(0xFFD9D9D9),
                      width: width,
                      controller: widget.controller1,
                      hintText: "Primeira avaliação",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFD9D9D9),
                      ),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.18,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ContainerInputNota(
                                  trimestre: widget.trimestrevalor,
                                  onChanged: (p0) {
                                    alunosProvider.setNotaSegundaAvaliacao(
                                        widget.trimestrevalor,
                                        0,
                                        double.tryParse(p0) ?? 0.0);
                                  },
                                  color: Colors.grey.shade500,
                                  width: MediaQuery.sizeOf(context).width * 0.2,
                                  controller: widget.controller2,
                                  hintText: "Nº 1",
                                ),
                                const Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                                ContainerInputNota(
                                  trimestre: widget.trimestrevalor,
                                  onChanged: (p0) {
                                    alunosProvider.setNotaSegundaAvaliacao(
                                        widget.trimestrevalor,
                                        1,
                                        double.tryParse(p0) ?? 0.0);
                                  },
                                  color: Colors.grey.shade500,
                                  width: MediaQuery.sizeOf(context).width * 0.2,
                                  controller: widget.controller3,
                                  hintText: "Nº 2",
                                ),
                                const Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                                ContainerInputNota(
                                  trimestre: widget.trimestrevalor,
                                  onChanged: (p0) {
                                    alunosProvider.setNotaSegundaAvaliacao(
                                        widget.trimestrevalor,
                                        2,
                                        double.tryParse(p0) ?? 0.0);
                                  },
                                  color: Colors.grey.shade500,
                                  width: MediaQuery.sizeOf(context).width * 0.2,
                                  controller: widget.controller4,
                                  hintText: "Nº 3",
                                ),
                              ],
                            ),
                            ContainerSegundaAvaliacao(
                                trimestre: widget.trimestrevalor)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          if (alunosProvider.mensagemErro != '')
                            Text(
                              alunosProvider.mensagemErro,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ContainerMedia(trimestre: widget.trimestrevalor)
                        ],
                      ),
                    ),
                    ContainerInputNota(
                        trimestre: widget.trimestrevalor,
                        controller: widget.controllerRecuperacaoParalela,
                        hintText: 'recuperação paralela',
                        width: width,
                        color: const Color(0xFFEFEFEF),
                        onChanged: (on) {
                          alunosProvider.setNotaRecuperacaoParalela(
                              double.tryParse(on) ?? 0.0,
                              widget.trimestrevalor);
                        }),
                    ButtomNotaSaved(
                      formKey: _key,
                      onpressed: widget.onpressed,
                    )
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
