import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/models/quiz.dart';
import 'package:nightingale_flutter_quizapp/models/quizzes.dart';
import 'package:nightingale_flutter_quizapp/widgets/common/gradient_container.dart';
import 'package:nightingale_flutter_quizapp/widgets/quiz/quiz_list_item.dart';
import 'package:provider/provider.dart';

class QuizListScreen extends StatelessWidget {
  static const routeName = '/quiz-list';

  const QuizListScreen({super.key});

  Future<void> _loadQuizzes(BuildContext context) async {
    await Provider.of<Quizzes>(context, listen: false).fetchAndSetQuizzes();
  }

  List<Widget> _buildQuizList(List<Quiz> quizzes) {
    return quizzes.map((quiz) => QuizListItem(quiz)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz List'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 55, 14, 80),
        actions: [
          IconButton(
            onPressed: () {
              // push named quiz form
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GradientContainer(
        child: FutureBuilder(
          future: _loadQuizzes(context),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : RefreshIndicator(
                  onRefresh: () => _loadQuizzes(context),
                  child: Consumer<Quizzes>(
                    builder: (context, value, child) => Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              ..._buildQuizList(value.quizzes),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
