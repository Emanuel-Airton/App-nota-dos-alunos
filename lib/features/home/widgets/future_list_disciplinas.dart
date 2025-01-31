import 'package:flutter/material.dart';
import 'package:flutter_app/features/disciplinas/models/disciplina_model.dart';
import 'package:flutter_app/features/disciplinas/views/view_disciplina.dart';
import 'package:flutter_app/widgets/container_disciplines.dart';

// ignore: must_be_immutable
class FutureListDisciplina extends StatefulWidget {
  Future<List<Disciplina>> listDisciplina;
  FutureListDisciplina({super.key, required this.listDisciplina});

  @override
  State<FutureListDisciplina> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FutureListDisciplina> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.listDisciplina,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Carregando dados...",
                style: CustomTextStyle.bodySmall);
          } else if (snapshot.hasError) {
            return Text(
              "erro ao carregar.",
              style: CustomTextStyle.bodySmall,
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              'Nenhuma disciplina cadastrada.',
              style: CustomTextStyle.bodySmall,
            ));
          } else {
            List<Disciplina> lista = snapshot.data!;
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 14);
                },
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  Disciplina disciplina = Disciplina();
                  disciplina.nomeDisciplina = lista[index].nomeDisciplina;
                  disciplina.turmas = lista[index].turmas;
                  Map<String, dynamic> map =
                      disciplina.toMap(disciplina.turmas);
                  debugPrint("map tesdte: ${map.toString()}");
                  return DisciplinesListItemWidget(
                    disciplina: lista[index].nomeDisciplina,
                    onTapImgImage: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PageDisciplina(mapTurma: map)));
                      //  debugPrint("aaaa${lista[index].turmas}");
                    },
                  );
                },
              ),
            );
          }
        });
  }
}
