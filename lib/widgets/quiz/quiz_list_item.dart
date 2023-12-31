import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';
import 'package:nightingale_flutter_quizapp/screens/questions_screen.dart';
import 'package:nightingale_flutter_quizapp/screens/quiz/quiz_form_screen.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_2.dart';
import 'package:provider/provider.dart';

import '../../providers/quizzes.dart';

class QuizListItem extends StatelessWidget {
  const QuizListItem(
    this.quiz, {
    super.key,
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const dismissibleVerticalMargin = 10.0;
    const dismissibleBorderRadius = 20.0;
    return Dismissible(
      key: ValueKey(quiz.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Quizzes>(context, listen: false).deleteQuiz(quiz);
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: dismissibleVerticalMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dismissibleBorderRadius),
          color: theme.colorScheme.error,
        ),
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.delete_forever,
            color: theme.colorScheme.onError,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        margin: const EdgeInsets.symmetric(vertical: dismissibleVerticalMargin),
        decoration: BoxDecoration(
            color: Colors.purple[900],
            borderRadius: BorderRadius.circular(dismissibleBorderRadius),
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
