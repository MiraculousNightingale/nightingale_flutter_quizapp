import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';
import 'package:nightingale_flutter_quizapp/widgets/common/gradient_container.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/quiz_form.dart';

class QuizFormScreen extends StatelessWidget {
  static const routeNameCreate = '/quiz-create';
  static const routeNameUpdate = '/quiz-update';
  const QuizFormScreen({super.key, required this.isCreateMode});
  final bool isCreateMode;

  @override
  Widget build(BuildContext context) {
    final Quiz quiz =
        (ModalRoute.of(context)!.settings.arguments as Map)['quiz'];
    // LayoutBuilder is a possible alternative but it changes the maxHeight
    // when a keyboard is opened.
    final mediaQuery = MediaQuery.of(context);
    final safeScreenHeight = mediaQuery.size.height -
        mediaQuery.viewPadding.top -
        mediaQuery.viewPadding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Form'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 55, 14, 80),
      ),
      body: GradientContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: safeScreenHeight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: QuizForm(
                  quiz: quiz,
                  isCreateMode: isCreateMode,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
