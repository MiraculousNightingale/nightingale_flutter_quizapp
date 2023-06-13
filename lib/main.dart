import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nightingale_flutter_quizapp/firebase_options.dart';
import 'package:nightingale_flutter_quizapp/models/quizzes.dart';
import 'package:nightingale_flutter_quizapp/routes.dart';
import 'package:nightingale_flutter_quizapp/screens/home_screen.dart';
import 'package:nightingale_flutter_quizapp/screens/questions_screen.dart';
import 'package:nightingale_flutter_quizapp/screens/quiz/quiz_list_screen.dart';
import 'package:nightingale_flutter_quizapp/screens/results_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Quizzes(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nightingale\'s Flutter Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.purple[800],
        ),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        QuizListScreen.routeName: (context) => const QuizListScreen(),
        Routes.questionsRoute: (context) => const QuestionsScreen(),
        Routes.resultsRoute: (context) => const ResultsScreen(),
      },
    );
  }
}
