import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextH2 extends StatelessWidget {
  const TextH2(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }
}
