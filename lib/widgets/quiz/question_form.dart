import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/quiz_text_field.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_3.dart';

class QuestionForm extends StatelessWidget {
  const QuestionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(11),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextH3('Question 1'),
          QuizTextField(
            labelText: 'Question text',
          ),
          QuizTextField(
            labelText: 'Answer 1 (Correct answer to the question)',
          ),
          QuizTextField(
            labelText: 'Answer 2',
          ),
          QuizTextField(
            labelText: 'Answer 3',
          ),
          QuizTextField(
            labelText: 'Answer 4',
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_left),
                  label: Text('Prev. question'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.plus_one),
                  label: Text('Add question'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
