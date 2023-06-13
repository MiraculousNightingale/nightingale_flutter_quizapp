class QuizQuestion {
  const QuizQuestion({required this.text, required this.answers});
  QuizQuestion.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        answers = List.from(json['answers']);

  final String text;
  final List<String> answers;

  List<String> get shuffledAnswers {
    return List.of(answers)..shuffle();
  }
}
