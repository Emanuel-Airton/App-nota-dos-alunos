import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/alunos/models/alunos_models.dart';
import 'package:flutter_app/features/alunos/provider/alunos_notas_provider.dart';
import 'package:flutter_app/features/alunos/database/alunos_firestore_service.dart';
import 'package:flutter_app/features/alunos/provider/notas_firebase_provider.dart';
import 'package:flutter_app/features/alunos/services/alunos_service.dart';
import 'package:flutter_app/features/alunos/widgets/animatedContainer_avaliacoes.dart';
import 'package:flutter_app/features/alunos/widgets/container_media_final.dart';
import 'package:flutter_app/features/alunos/widgets/container_nome_aluno.dart';
import 'package:flutter_app/features/alunos/widgets/snackBar_erro_salvar_nota.dart';
import 'package:flutter_app/features/alunos/widgets/snackBarNotaSalva.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:flutter_app/widgets/customBackGroundLayout.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageAluno extends StatefulWidget {
  Alunos alunos;
  late String nomeTurma;
  late Disciplina disciplina;
  PageAluno(
      {super.key,
      required this.alunos,
      required this.disciplina,
      required this.nomeTurma});

  @override
  State<PageAluno> createState() => _PageAlunoState();
}

class _PageAlunoState extends State<PageAluno> {
  List<TextEditingController> controllers = [];
  final List<VoidCallback> listeners = [];
  AlunosServices alunosServices = AlunosServices();
  double media = 0.0;
  double notaAvaliacao2 = 0.0;
  AlunosFirestoreService alunosFirestoreService = AlunosFirestoreService();
  List<Map> list = [];
  late int indice;
  final primeiroTrimestre = 'I trimestre';
  final segundoTrimestre = 'II trimestre';
  final terceiroTrimestre = 'III trimestre';
  @override
  void initState() {
    controllers = alunosServices.addListenerController();
    debugPrint('initState called for PageAluno');
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('dispose called for PageAluno');
    controllers = alunosServices.removelistener(controllers);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alunosProvider =
        Provider.of<AlunosNotasProvider>(context, listen: false);
    final alunosfirestoreProvider =
        Provider.of<AlunosfirestoreProvider>(context, listen: false);
    // ignore: deprecated_member_use
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          debugPrint(
                              'valor da lista limpa: ${alunosfirestoreProvider.listNotasDisciplina}');
                          Navigator.pop(context);
                          alunosProvider.resetarTodosTrimestres();
                          alunosfirestoreProvider.limparLista();
                          alunosfirestoreProvider.limparMap();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Text('Aluno/Avaliações',
                          style: CustomTextStyle.fontInfoTop),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ContainerNomeAluno(
                  disciplina: widget.disciplina, alunos: widget.alunos),
            ),
            Flexible(
              child: Stack(
                children: [
                  CustomBackgroundLayout(
                    child1: Container(),
                    child2: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          AnimatedContainerAvaliacoes(
                              disciplina: widget.disciplina,
                              nomeTurma: widget.nomeTurma,
                              aluno: widget.alunos,
                              trimestrevalor: primeiroTrimestre,
                              controller1: controllers[0],
                              controller2: controllers[1],
                              controller3: controllers[2],
                              controller4: controllers[3],
                              controllerRecuperacaoParalela: controllers[4],
                              trimestre: '1° trimestre',
                              onpressed: () {
                                try {
                                  alunosServices.salvar(
                                      widget.disciplina.nomeDisciplina,
                                      primeiroTrimestre,
                                      alunosProvider.media[primeiroTrimestre],
                                      widget.alunos.documentAluno,
                                      widget.nomeTurma);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBarNotaSalva().snackbar(context));
                                  alunosFirestoreService.streamNotas(
                                      widget.alunos.documentAluno,
                                      widget.nomeTurma,
                                      widget.disciplina.nomeDisciplina,
                                      alunosfirestoreProvider);
                                  //     alunosfirestoreProvider.setListNotasDisciplina(list);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBarWidget().snackbar(context));
                                }
                              }),
                          AnimatedContainerAvaliacoes(
                            disciplina: widget.disciplina,
                            nomeTurma: widget.nomeTurma,
                            aluno: widget.alunos,
                            trimestrevalor: segundoTrimestre,
                            controller1: controllers[5],
                            controller2: controllers[6],
                            controller3: controllers[7],
                            controller4: controllers[8],
                            controllerRecuperacaoParalela: controllers[9],
                            trimestre: '2° trimestre',
                            onpressed: () {
                              try {
                                alunosServices.salvar(
                                    widget.disciplina.nomeDisciplina,
                                    segundoTrimestre,
                                    alunosProvider.media[segundoTrimestre],
                                    widget.alunos.documentAluno,
                                    widget.nomeTurma);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarNotaSalva().snackbar(context));
                                alunosFirestoreService.streamNotas(
                                    widget.alunos.documentAluno,
                                    widget.nomeTurma,
                                    widget.disciplina.nomeDisciplina,
                                    alunosfirestoreProvider);
                                //    alunosfirestoreProvider.setListNotasDisciplina(list);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarWidget().snackbar(context));
                              }
                            },
                          ),
                          AnimatedContainerAvaliacoes(
                            disciplina: widget.disciplina,
                            nomeTurma: widget.nomeTurma,
                            aluno: widget.alunos,
                            trimestrevalor: terceiroTrimestre,
                            controller1: controllers[10],
                            controller2: controllers[11],
                            controller3: controllers[12],
                            controller4: controllers[13],
                            controllerRecuperacaoParalela: controllers[14],
                            trimestre: '3° trimestre',
                            onpressed: () {
                              try {
                                alunosServices.salvar(
                                  widget.disciplina.nomeDisciplina,
                                  terceiroTrimestre,
                                  alunosProvider.media[terceiroTrimestre],
                                  widget.alunos.documentAluno,
                                  widget.nomeTurma,
                                );
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarNotaSalva().snackbar(context));
                                alunosFirestoreService.streamNotas(
                                    widget.alunos.documentAluno,
                                    widget.nomeTurma,
                                    widget.disciplina.nomeDisciplina,
                                    alunosfirestoreProvider);
                                //   alunosfirestoreProvider.setListNotasDisciplina(list);
                              } catch (e) {
                                debugPrint('erro: ${e.toString()}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarWidget().snackbar(context));
                              }
                            },
                          ),
                          ContainerMediaFinal(
                            alunos: widget.alunos,
                            disciplina: widget.disciplina,
                          )
                        ],
                      ),
                    ),
                    child3: Container(),
                    heightContainer: 0.8,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
