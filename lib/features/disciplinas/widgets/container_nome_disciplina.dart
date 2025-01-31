import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/container_disciplines.dart';

// ignore: must_be_immutable
class ContainerNomeDisciplina extends StatelessWidget {
  late String nomeDisciplina;
  ContainerNomeDisciplina({super.key, required this.nomeDisciplina});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1.2),
      child: Container(
        decoration: BoxDecoration(),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
              ],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 3, color: Colors.white)),
          child: DisciplinesListItemWidget(
            disciplina: nomeDisciplina,
          ),
        ),
      ),
    );
  }
}
