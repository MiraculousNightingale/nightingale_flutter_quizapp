import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/assets.dart';
import 'package:nightingale_flutter_quizapp/screens/quiz/quiz_list_screen.dart';
import 'package:nightingale_flutter_quizapp/widgets/common/gradient_container.dart';
import 'package:nightingale_flutter_quizapp/routes.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_1.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_3.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                Assets.quizLogo,
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                width: 300,
              ),
              const TextH1('Nightingale\'s Flutter Quiz App'),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.questionsRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 9,
                ),
                icon: const Icon(Icons.arrow_right_alt),
                label: const TextH3('Start Quiz'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(QuizListScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 9,
                ),
                icon: const Icon(Icons.list),
                label: const TextH3('View Quiz List'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.questionsRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 9,
                ),
                icon: const Icon(Icons.create),
                label: const TextH3('Create A New Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
