import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextNameAluno extends StatelessWidget {
  late String nomeAluno;
  TextNameAluno({super.key, required this.nomeAluno});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(nomeAluno!,
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: const Color(0xFFED6969),
          )),
    );
  }
}
