class QuizQuestion {
  QuizQuestion({required this.text, required this.answers});
  QuizQuestion.empty()
      : text = '',
        answers = [for (var i = 0; i < 4; i++) ''];

  static const keyText = 'text';
  static const keyAnswers = 'answers';

  QuizQuestion.fromJson(Map<String, dynamic> json)
      : text = json[keyText],
        answers = List.from(json[keyAnswers]);
  Map<String, dynamic> toJson() => {
        keyText: text,
        keyAnswers: answers,
      };

  String text;
  final List<String> answers;

  List<String> get shuffledAnswers {
    return List.of(answers)..shuffle();
  }
}
