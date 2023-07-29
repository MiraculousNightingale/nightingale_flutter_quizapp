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
  FocusNode questionTextFocusNode = FocusNode();
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

  void _goToPreviousQuestion() {
    setState(() {
      currentQuestionIndex--;
      _setupTextController(currentQuestionIndex);
    });
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
          SizedBox(
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextH3('Question ${currentQuestionIndex + 1}'),
                    if (!isFirstQuestion)
                      ElevatedButton.icon(
                        onPressed: () {
                          if (isFirstQuestion) {
                            questionTextController.clear();
                            for (final controller in answerControllers) {
                              controller.clear();
                            }
                          } else {
                            widget.questions.removeAt(currentQuestionIndex);
                            _goToPreviousQuestion();
                          }
                        },
                        icon: const Icon(Icons.delete),
                        label: Text(isFirstQuestion ? 'Clear' : 'Remove'),
                      ),
                  ],
                ),
              ],
            ),
          ),
          QuizTextField(
            controller: questionTextController,
            labelText: 'Question text',
            textInputAction: TextInputAction.next,
            focusNode: questionTextFocusNode,
          ),
          for (var i = 0; i < answerControllers.length; i++)
            QuizTextField(
              controller: answerControllers[i],
              labelText: 'Answer ${i + 1}',
              textInputAction: i < answerControllers.length - 1
                  ? TextInputAction.next
                  : TextInputAction.done,
            ),
          Row(
            children: [
              if (!isFirstQuestion)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _goToPreviousQuestion,
                    icon: const Icon(Icons.arrow_left),
                    label: const Text('Prev. question'),
                  ),
                ),
              if (!isFirstQuestion)
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
                          questionTextFocusNode.requestFocus();
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
