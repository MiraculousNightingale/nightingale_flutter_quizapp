import 'package:flutter/material.dart';
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
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: safeScreenHeight,
              child: Column(
                children: [
                  TextH1(isCreateMode ? 'Creating a Quiz' : 'Updating a Quiz'),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: QuizTextField(
                      labelText: 'Title',
                    ),
                  ),
                  Expanded(
                    child: QuestionForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
