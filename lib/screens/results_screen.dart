import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/widgets/common/gradient_container.dart';
import 'package:nightingale_flutter_quizapp/questions.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_1.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results';

  const ResultsScreen({super.key});

  List<Widget> _buildResults(List<String> selectedAnswers) {
    final List<Widget> results = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      final answer = selectedAnswers[i];
      final correctAnswer = null;
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
                      'null',
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
    final selectedAnswers =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    var correctAnswers = 0;
    selectedAnswers.asMap().forEach((key, value) {
      if (value == 0) correctAnswers++;
    });
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextH1(
                  'You answered $correctAnswers out of ${selectedAnswers.length} questions correctly',
                ),
              ),
              // ..._buildResults(selectedAnswers),
              Expanded(
                child: ListView(
                  children: _buildResults(selectedAnswers),
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
