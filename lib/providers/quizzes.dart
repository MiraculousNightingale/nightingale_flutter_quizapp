import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';

class Quizzes with ChangeNotifier {
  final _firebase = FirebaseFirestore.instance;
  final List<Quiz> _quizzes = [];

  List<Quiz> get quizzes {
    return [..._quizzes];
  }

  Future<void> fetchAndSetQuizzes() async {
    final quizDocs = (await _firebase.collection('quizzes').get()).docs;
    _quizzes.clear();
    for (final quizDoc in quizDocs) {
      _quizzes.add(Quiz.fromJson(quizDoc.id, quizDoc.data()));
    }
    notifyListeners();
  }

  Future<void> createQuiz(Quiz quiz) async {
    await _firebase.collection('quizzes').add(quiz.toJson());
  }

  Future<void> updateQuiz(Quiz quiz) async {
    await _firebase.collection('quizzes').doc(quiz.id).set(quiz.toJson());
  }
}
