import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/provider/alunos_notas_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ContainerMedia extends StatefulWidget {
  late String trimestre;
  ContainerMedia({super.key, required this.trimestre});

  @override
  State<ContainerMedia> createState() => _ContainerMediaState();
}

class _ContainerMediaState extends State<ContainerMedia> {
  @override
  Widget build(BuildContext context) {
    final alunosProvider =
        Provider.of<AlunosNotasProvider>(context, listen: true);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: alunosProvider.media[widget.trimestre] < 6.0
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSecondaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Média: ',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: const Color(0xFFFFFFFF),
              ),
            ),
            Text(
              // alunosProvider.media.toStringAsFixed(1),
              alunosProvider.media[widget.trimestre]
                  .toStringAsFixed(1), // media.toStringAsFixed(1),
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
