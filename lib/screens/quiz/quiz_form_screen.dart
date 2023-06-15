import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';
import 'package:nightingale_flutter_quizapp/widgets/common/gradient_container.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/question_form.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/quiz_text_field.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_1.dart';

class QuizFormScreen extends StatelessWidget {
  static const routeNameCreate = '/quiz-create';
  static const routeNameUpdate = '/quiz-update';
  const QuizFormScreen({super.key, required this.isCreateMode});
  final bool isCreateMode;

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder is a possible alternative but it changes the maxHeight
    // when a keyboard is opened.
    final mediaQuery = MediaQuery.of(context);
    final safeScreenHeight = mediaQuery.size.height -
        mediaQuery.viewPadding.top -
        mediaQuery.viewPadding.bottom;
    final quiz =
        (ModalRoute.of(context)!.settings.arguments as Map)['quiz'] as Quiz;

    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: safeScreenHeight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextH1(
                        isCreateMode ? 'Creating a Quiz' : 'Updating a Quiz'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: QuizTextField(
                        labelText: 'Title',
                        onChanged: (currentText) => quiz.title = currentText,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: QuestionForm(quiz.questions),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      onPressed: () {
                        print(quiz.title);
                        print(quiz.questions[0].answers[0]);
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
