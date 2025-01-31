import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class InputChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(11.5, 5, 11.5, 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '7.0',
        style: GoogleFonts.getFont(
          'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.4,
          letterSpacing: 0.1,
          color: const Color(0xFF49454F),
        ),
      ),
    );
  }
}
