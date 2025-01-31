import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/disciplinas/models/disciplina_model.dart';
import 'package:flutter_app/features/home/widgets/future_list_disciplinas.dart';

// ignore: must_be_immutable
class ColumnContentDisciplinas extends StatelessWidget {
  Future<List<Disciplina>> listDisciplina;
  ColumnContentDisciplinas({super.key, required this.listDisciplina});

  @override
  Widget build(BuildContext context) {
    return Column(
      //  mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            'Disciplinas',
            style: CustomTextStyle.headlineSmallWhiteA700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            'Essas são as disciplinas que você ministra',
            style: CustomTextStyle.bodySmall,
          ),
        ),
        const SizedBox(height: 25),
        FutureListDisciplina(listDisciplina: listDisciplina)
      ],
    );
  }
}
