import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/features/alunos/provider/alunos_notas_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ContainerInputNota extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  late String hintText;
  late double width;
  late Color color;
  late String trimestre;
  Function(String)? onChanged;
  ContainerInputNota(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.width,
      required this.color,
      required this.onChanged,
      required this.trimestre});

  @override
  State<ContainerInputNota> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ContainerInputNota> {
  bool disabled = true;
  @override
  Widget build(BuildContext context) {
    final alunoNotasProvider =
        Provider.of<AlunosNotasProvider>(context, listen: true);
    return Container(
      alignment: Alignment.center,
      //  margin: const EdgeInsets.only(top: 8),
      child: Container(
        width: widget.width,
        height: MediaQuery.of(context).size.height * 0.06,
        padding: const EdgeInsets.only(
          left: 5,
          top: 12,
          right: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: widget.color, width: 2),
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(0, 10, 5, 1),
            child: TextFormField(
                validator: (value) {
                  if (widget.hintText == 'recuperação paralela') {
                    debugPrint(alunoNotasProvider.media.toString());
                    if (alunoNotasProvider.media[widget.trimestre] < 7 &&
                        value!.isEmpty) {
                      return 'insira a nota da recuperação';
                    }
                  } else if (value!.isEmpty) {
                    return 'insira a nota';
                  }
                  return null;
                },
                maxLength: 3,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: widget.controller,
                enabled: alunoNotasProvider.media[widget.trimestre] > 7 &&
                        widget.hintText == 'recuperação paralela' &&
                        alunoNotasProvider
                                .getNotaRecuperacaoParalela(widget.trimestre) ==
                            0.0
                    ? false
                    : true,
                keyboardType: TextInputType.number,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7E7E7E))))),
      ),
    );
  }
}
