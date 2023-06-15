import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz_question.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/quiz_text_field.dart';
import 'package:nightingale_flutter_quizapp/widgets/text/text_h_3.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm(this.questions, {super.key});
  final List<QuizQuestion> questions;

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  var currentQuestionIndex = 0;

  TextEditingController questionTextController = TextEditingController();
  final List<TextEditingController> answerControllers = [
    for (var i = 0; i < 4; i++) TextEditingController()
  ];

  void _setupTextController(int questionIndex, {bool isInitializing = false}) {
    // dispose old controllers if switching between questions
    if (!isInitializing) {
      _disposeTextControllers();
      questionTextController = TextEditingController();
      answerControllers.clear();
      answerControllers.addAll([
        for (var i = 0; i < 4; i++) TextEditingController(),
      ]);
    }

    // reinitialize controllers
    final currentQuestion = widget.questions[currentQuestionIndex];
    questionTextController.text = currentQuestion.text;
    questionTextController.addListener(() {
      currentQuestion.text = questionTextController.text;
    });
    for (var i = 0; i < answerControllers.length; i++) {
      final controller = answerControllers[i];
      controller.text = currentQuestion.answers[i];
      controller.addListener(() {
        currentQuestion.answers[i] = controller.text;
      });
    }
  }

  void _disposeTextControllers() {
    questionTextController.dispose();
    for (final controller in answerControllers) {
      controller.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    _setupTextController(
      currentQuestionIndex, // by default 0
      isInitializing: true,
    );
  }

  @override
  void dispose() {
    _disposeTextControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFirstQuestion = currentQuestionIndex == 0;
    final isLastQuestion = currentQuestionIndex == widget.questions.length - 1;
    return Container(
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
          TextH3('Question ${currentQuestionIndex + 1}'),
          QuizTextField(
            controller: questionTextController,
            labelText: 'Question text',
          ),
          for (var i = 0; i < answerControllers.length; i++)
            QuizTextField(
              controller: answerControllers[i],
              labelText: 'Answer ${i + 1}',
            ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (!isFirstQuestion) {
                      setState(() {
                        currentQuestionIndex--;
                        _setupTextController(currentQuestionIndex);
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_left),
                  label: const Text('Prev. question'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: isLastQuestion
                    ? ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            widget.questions.add(QuizQuestion.empty());
                            currentQuestionIndex++;
                            _setupTextController(currentQuestionIndex);
                          });
                        },
                        icon: const Icon(Icons.plus_one),
                        label: const Text('Add question'),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            currentQuestionIndex++;
                            _setupTextController(currentQuestionIndex);
                          });
                        },
                        icon: const Icon(Icons.arrow_right),
                        label: const Text('Next question'),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
