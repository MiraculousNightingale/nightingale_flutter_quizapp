class QuizQuestion {
  QuizQuestion({required this.text, required this.answers});
  QuizQuestion.empty()
      : text = '',
        answers = [for (var i = 0; i < 4; i++) ''];
  QuizQuestion.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        answers = List.from(json['answers']);

  String text;
  final List<String> answers;

  List<String> get shuffledAnswers {
    return List.of(answers)..shuffle();
  }
}
