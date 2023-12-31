import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz_question.dart';

class Quiz with ChangeNotifier {
  final String id;
  String title;
  final List<QuizQuestion> questions;

  Quiz({required this.id, required this.title, required this.questions});
  Quiz.empty()
      : id = '',
        title = '',
        questions = [QuizQuestion.empty()];

  // JSON Keys
  static const keyId = 'id';
  static const keyTitle = 'title';
  static const keyQuestions = 'questions';

  static List<QuizQuestion> _questionsFromJsonArray(json) {
    if (json == null) {
      return [];
    }
    return List.from(json).map((e) => QuizQuestion.fromJson(e)).toList();
  }

  List<Map<String, dynamic>> _questionsToJsonArray() =>
      questions.map((e) => e.toJson()).toList();

  Quiz.fromJson(this.id, Map<String, dynamic> json)
      : title = json[keyTitle],
        questions = _questionsFromJsonArray(json[keyQuestions]);

  Map<String, dynamic> toJson() => {
        keyTitle: title,
        keyQuestions: _questionsToJsonArray(),
      };
}
