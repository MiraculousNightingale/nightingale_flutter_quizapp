import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextH3 extends StatelessWidget {
  const TextH3(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
