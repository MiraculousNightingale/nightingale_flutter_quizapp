import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';
import 'package:nightingale_flutter_quizapp/widgets/common/gradient_container.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_2.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results';

  const ResultsScreen({super.key});

  List<Widget> _buildResults(Quiz quiz, List<String> selectedAnswers) {
    final List<Widget> results = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      final question = quiz.questions[i];
      final answer = selectedAnswers[i];
      final correctAnswer = question.answers.first;
      final isCorrect = answer == correctAnswer;
      results.add(
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 44, 1, 65),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? const Color.fromARGB(255, 59, 174, 182)
                        : const Color.fromARGB(255, 219, 74, 164),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.text,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (!isCorrect)
                      Text(
                        answer,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 219, 74, 164),
                        ),
                      ),
                    Text(
                      correctAnswer,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 59, 174, 182),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final quiz = routeArgs['quiz'] as Quiz;
    final selectedAnswers = routeArgs['selectedAnswers'] as List<String>;
    var correctAnswers = 0;
    selectedAnswers.asMap().forEach((key, value) {
      if (value == quiz.questions[key].answers.first) correctAnswers++;
    });
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                child: TextH2(
                  'You answered $correctAnswers out of ${selectedAnswers.length} questions correctly',
                ),
              ),
              Expanded(
                child: ListView(
                  children: _buildResults(quiz, selectedAnswers),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 79, 0, 99),
                  ),
                  child: const Text(
                    'Back to main menu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
