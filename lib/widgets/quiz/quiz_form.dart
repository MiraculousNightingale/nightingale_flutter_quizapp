import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';
import 'package:nightingale_flutter_quizapp/providers/quizzes.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/question_form.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/quiz_text_field.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_1.dart';
import 'package:provider/provider.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({super.key, required this.quiz, required this.isCreateMode});
  final Quiz quiz;
  final bool isCreateMode;

  @override
  State<QuizForm> createState() => _QuizForm();
}

class _QuizForm extends State<QuizForm> {
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.quiz.title;
    titleController.addListener(() => widget.quiz.title = titleController.text);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  bool _validateQuiz() {
    final quiz = widget.quiz;
    final isInvalid = quiz.title.trim().isEmpty ||
        quiz.questions.any((question) =>
            question.text.trim().isEmpty ||
            question.answers.any((answer) => answer.trim().isEmpty));
    if (isInvalid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Empty fields",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          content: const Text(
            "All quiz and question fields must be not empty.",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Column(
      children: [
        TextH1(
          widget.isCreateMode ? 'Creating a Quiz' : 'Updating a Quiz',
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: QuizTextField(
            controller: titleController,
            labelText: 'Title',
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: QuestionForm(widget.quiz.questions),
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
          ),
          onPressed: () async {
            if (_validateQuiz()) {
              if (widget.isCreateMode) {
                await Provider.of<Quizzes>(context, listen: false)
                    .createQuiz(widget.quiz);
              } else {
                await Provider.of<Quizzes>(context, listen: false)
                    .updateQuiz(widget.quiz);
              }
              navigator.pop();
            }
          },
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        ),
      ],
    );
  }
}
