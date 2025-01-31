import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/provider/alunos_notas_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ButtomNotaSaved extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  void Function()? onpressed;
  ButtomNotaSaved({super.key, required this.formKey, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final alunoNotasProvider =
        Provider.of<AlunosNotasProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color(0xFFED6969),
          ),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFEFEFEF),
        ),
        child: TextButton(
          onPressed: () {
            if (formKey.currentState!.validate() &&
                alunoNotasProvider.mensagemErro == '') {
              onpressed!();
            }
          },
          child: const Text("Salvar nota"),
        ),
      ),
    );
  }
}
