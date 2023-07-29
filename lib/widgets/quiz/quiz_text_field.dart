import 'package:flutter/material.dart';

class QuizTextField extends StatelessWidget {
  const QuizTextField({
    super.key,
    this.labelText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
  });

  final String? labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(11),
        label: Text(labelText ?? ''),
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      focusNode: focusNode,
    );
  }
}
