import 'package:flutter/material.dart';

class QuizTextField extends StatelessWidget {
  const QuizTextField({
    super.key,
    this.labelText,
    this.controller,
  });

  final String? labelText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(11),
        label: Text(labelText ?? ''),
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
