import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/database/alunos_firestore_service.dart';
import 'package:flutter_app/features/alunos/models/alunos_models.dart';
import 'package:flutter_app/features/alunos/provider/notas_firebase_provider.dart';
import 'package:flutter_app/features/alunos/views/page_aluno.dart';
import 'package:flutter_app/features/turmas/widgets/circle_avatar_number.dart';
import 'package:flutter_app/features/turmas/widgets/text_name_aluno.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FutureBuilderDataAluno extends StatefulWidget {
  Future<Map<dynamic, dynamic>> map;
  late Disciplina nomeDisciplina;
  late String nomeTurma;
  FutureBuilderDataAluno(
      {super.key,
      required this.map,
      required this.nomeDisciplina,
      required this.nomeTurma});

  @override
  State<FutureBuilderDataAluno> createState() => _FutureBuilderDataAlunoState();
}

class _FutureBuilderDataAlunoState extends State<FutureBuilderDataAluno> {
  List<Map> list = [];
  @override
  Widget build(BuildContext context) {
    final alunosProvider =
        Provider.of<AlunosfirestoreProvider>(context, listen: false);
    return FutureBuilder(
      future: widget.map,
      builder: (context, snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.none:
          case ConnectionState.active:
            return const Center(
              child: Text("Sem dados"),
            );
          case ConnectionState.done:
            Map<dynamic, dynamic> dados = snapShot.data!;
            List<Map> list = dados["alunos"];
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (context, index) {
                int cont = index + 1;
                Alunos alunos = Alunos(
                  nomeAluno: list[index]["nome"],
                  documentAluno: list[index]["id"],
                );
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 5, right: 5),
                  child: GestureDetector(
                    onTap: () {
                      AlunosFirestoreService alunosFirestoreService =
                          AlunosFirestoreService();
                      alunosFirestoreService.streamNotas(
                          alunos.documentAluno,
                          widget.nomeTurma,
                          widget.nomeDisciplina.nomeDisciplina,
                          alunosProvider);
                      // debugPrint('lista de alunos: $list');
                      //   alunosProvider.setListNotasDisciplina(list);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              maintainState:
                                  false, // Isso garante que o estado da PageTurma seja mantido.
                              builder: (context) => PageAluno(
                                    alunos: alunos,
                                    disciplina: widget.nomeDisciplina,
                                    nomeTurma: widget.nomeTurma,
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 80,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(0, 3),
                              color: Colors.grey)
                        ],
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          CircleAvatarNumber(cont: cont),
                          Flexible(
                            child: TextNameAluno(
                                nomeAluno: alunos.nomeAluno ?? ''),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
