import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_3.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {super.key, required this.onPressed, required this.buttonText});

  final void Function()? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        minimumSize: const Size(300, 0),
        backgroundColor: const Color.fromRGBO(23, 1, 44, 1),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: TextH3(buttonText),
    );
  }
}
