import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/answer_button.dart';
import 'package:nightingale_flutter_quizapp/widgets/common/gradient_container.dart';
import 'package:nightingale_flutter_quizapp/models/quiz_question.dart';
import 'package:nightingale_flutter_quizapp/questions.dart';
import 'package:nightingale_flutter_quizapp/routes.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_1.dart';

class QuestionsScreen extends StatefulWidget {
  static const routeName = '/questions';

  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  final List<String> selectedAnswers = [];

  // using a column with spacearound is definetely easier
  List<Widget> _buildButtons(QuizQuestion question) {
    final List<Widget> buttonSizedBoxPairs = [];

    question.shuffledAnswers
        .map((answer) => [
              AnswerButton(
                onPressed: currentQuestionIndex >= 0
                    ? () {
                        // send selectedAnswers to target route
                        selectedAnswers.add(answer);
                        Navigator.of(context).pushReplacementNamed(
                          Routes.resultsRoute,
                          arguments: selectedAnswers,
                        );
                      }
                    : () {
                        setState(() {
                          selectedAnswers.add(answer);
                          currentQuestionIndex++;
                        });
                      },
                buttonText: answer,
              ),
              const SizedBox(
                height: 15,
              ),
            ])
        .forEach((pair) {
      buttonSizedBoxPairs.addAll(pair);
    });
    return buttonSizedBoxPairs;
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = null;
    return Scaffold(
      body: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextH1(currentQuestion.text)),
              const SizedBox(
                height: 30,
              ),
              ..._buildButtons(currentQuestion),
            ],
          ),
        ),
      ),
    );
  }
}
