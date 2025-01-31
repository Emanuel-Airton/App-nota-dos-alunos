import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField {
  static textField({required String hint}) => InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        labelText: hint,
        labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: const Color(0xFF7E7E7E),
        ),
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: const Color(0xFF7E7E7E),
        ),
      );
}
