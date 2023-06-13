import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz_question.dart';

class Quiz with ChangeNotifier {
  Quiz({required this.id, required this.title, required this.questions});
  Quiz.fromJson(this.id, Map<String, dynamic> json)
      : title = json['title'],
        questions = List.from(json['questions'])
            .map((e) => QuizQuestion.fromJson(e))
            .toList();

  final String id;
  final String title;
  final List<QuizQuestion> questions;
}
