import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension on TextStyle {
  /* TextStyle get roboto {
    return copyWith(
      fontFamily: 'ROBOTO',
    );
  }*/
}

class CustomTextStyle {
  static get fontInfoAlunoWhite => TextStyle(
      color: Colors.grey[600], fontWeight: FontWeight.w700, fontSize: 14);

  static get fontInfoTop => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 20,
        color: Color(0xFFFFFFFF),
      );
  static get headlineSmallWhiteA700 => TextStyle(
      color: Colors.grey[600],
      fontSize: 22,
      fontFamily: 'ROBOTO',
      fontWeight: FontWeight.w700);

  static get bodySmall => const TextStyle(
      color: Color(0xFF9E9E9E),
      fontSize: 14,
      fontFamily: 'ROBOTO',
      fontWeight: FontWeight.w400);

  static get bodySmallHorario => const TextStyle(
      color: Color.fromRGBO(237, 105, 105, 1),
      fontSize: 16,
      fontFamily: 'ROBOTO',
      fontWeight: FontWeight.w500);
  static get titleLargeWhite => const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'ROBOTO',
      fontWeight: FontWeight.w700);

  static get fontDiscipline => const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35);

  static get fontTurma => const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);

  static get fontTurmaHorario => const TextStyle(
      color: Color(0xFF9E9E9E), fontWeight: FontWeight.bold, fontSize: 22);

  static get fontButtom => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.white,
      );
  static get fontAlertDialog => const TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'ROBOTO',
      fontSize: 16,
      color: Colors.white);

  static get titleLargeLogin => const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 30,
        fontFamily: 'ROBOTO',
        color: Color.fromRGBO(237, 105, 105, 1),
      );
  static get titleSmallLogin => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontFamily: 'ROBOTO',
        color: Color.fromRGBO(237, 105, 105, 1),
      );
}
