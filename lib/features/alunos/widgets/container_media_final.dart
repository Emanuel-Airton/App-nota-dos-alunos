import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/alunos/models/alunos_models.dart';
import 'package:flutter_app/features/alunos/provider/notas_firebase_provider.dart';
import 'package:flutter_app/features/alunos/services/alunos_service.dart';
import 'package:flutter_app/features/alunos/widgets/buttom_nota_saved.dart';
import 'package:flutter_app/models/model_disciplina.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/features/alunos/database/alunos_firestore_service.dart';

// ignore: must_be_immutable
class ContainerMediaFinal extends StatefulWidget {
  late Alunos alunos;
  late Disciplina disciplina;
  ContainerMediaFinal(
      {super.key, required this.alunos, required this.disciplina});

  @override
  State<ContainerMediaFinal> createState() => _MyWidgetState();
}

AlunosServices alunosServices = AlunosServices();
//Notas notas = Notas();

class _MyWidgetState extends State<ContainerMediaFinal> {
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      alunosServices.controlleraddlistener(controller);
    });
  }

  late AlunosFirestoreService alunosFirestoreService = AlunosFirestoreService();
  TextEditingController controller = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final alunosProvider =
        Provider.of<AlunosfirestoreProvider>(context, listen: true);
    debugPrint(alunosProvider.notaBaixa.toString());
    // debugPrint(alunosProvider.mediaFinalExiste.toString());

    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Container(
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 10),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
                ],
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(15)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Média final',
                  style: CustomTextStyle.headlineSmallWhiteA700),
              Text(
                  alunosProvider.notasDisciplinas['Média final'] != null
                      ? 'Nota: ${alunosProvider.notasDisciplinas['Média final'][widget.disciplina.nomeDisciplina].toString()}'
                      : '',
                  style: CustomTextStyle.bodySmall),
              alunosProvider.notaBaixa
                  ? Column(
                      children: [
                        Form(
                          key: _key,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'insira a nota da recuperação final';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Nota da recuperação final',
                            ),
                            controller: controller,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            enabled: true,
                          ),
                        ),
                        ButtomNotaSaved(
                          formKey: _key,
                          onpressed: () {
                            double nota = double.parse(controller.text);
                            try {
                              alunosServices.recuperacaoMediaFinal(
                                  alunosProvider.notasDisciplinas,
                                  widget.disciplina.nomeDisciplina,
                                  nota,
                                  widget.alunos);
                            } catch (e) {
                              debugPrint('erro: $e');
                            }
                          },
                        )
                      ],
                    )
                  : Container()
            ])));
  }
}
