import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';
import 'package:nightingale_flutter_quizapp/screens/results_screen.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/answer_button.dart';
import 'package:nightingale_flutter_quizapp/widgets/common/gradient_container.dart';
import 'package:nightingale_flutter_quizapp/models/quiz_question.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_1.dart';

class QuestionsScreen extends StatefulWidget {
  static const routeName = '/questions';

  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  late final Quiz quiz;
  final List<String> selectedAnswers = [];

  bool get hasNoQuestions => quiz.questions.isEmpty;
  bool get isLastQuestion => currentQuestionIndex >= quiz.questions.length - 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    quiz = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['quiz'];
  }

  // using a column with spacearound is definetely easier
  List<Widget> _buildButtons(QuizQuestion question) {
    return question.shuffledAnswers
        .map(
          (answer) => Padding(
            padding: const EdgeInsets.all(7.5),
            child: AnswerButton(
              onPressed: isLastQuestion
                  ? () {
                      // send selectedAnswers to target route
                      selectedAnswers.add(answer);
                      Navigator.of(context).pushReplacementNamed(
                        ResultsScreen.routeName,
                        arguments: {
                          'quiz': quiz,
                          'selectedAnswers': selectedAnswers,
                        },
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
          ),
        )
        .toList();
  }

  Widget _buildQuestionScreen(QuizQuestion question) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextH1(question.text),
          ),
          const SizedBox(
            height: 30,
          ),
          ..._buildButtons(question),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientContainer(
      child: SafeArea(
        child: hasNoQuestions
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TextH1('This quiz has no questions!'),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Return'),
                  ),
                ],
              )
            : _buildQuestionScreen(quiz.questions[currentQuestionIndex]),
      ),
    ));
  }
}
