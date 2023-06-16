import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';
import 'package:nightingale_flutter_quizapp/screens/questions_screen.dart';
import 'package:nightingale_flutter_quizapp/screens/quiz/quiz_form_screen.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_2.dart';

class QuizListItem extends StatelessWidget {
  const QuizListItem(
    this.quiz, {
    super.key,
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(quiz.id),
      child: Container(
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.purple[900],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                blurRadius: 5,
              )
            ]),
        child: Row(
          children: [
            Expanded(child: TextH2(quiz.title)),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  QuizFormScreen.routeNameUpdate,
                  arguments: {
                    'quiz': quiz,
                  },
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  QuestionsScreen.routeName,
                  arguments: {
                    'quiz': quiz,
                  },
                );
              },
              icon: const Icon(
                Icons.play_arrow,
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
