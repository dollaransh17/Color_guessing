import 'package:flutter/material.dart';            // For Flutter core widgets, State, Widget, BuildContext, Colors, Scaffold, etc.
import 'dart:math';                                // For Random
 // For Fluttertoast
import './random-rgb.dart';                        // Your RGB widget (or change path as needed)
import './color_options.dart';                     // Your ColorOptions widget
import './result.dart';                            // Your Result widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const MyHomePage(title: 'Color Guessing Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Random random = Random();

  late int randomR;
  late int randomG;
  late int randomB;

  int totalScore = 0;
  int questionCount = 0;

  @override
  void initState() {
    super.initState();
    generateRandomColor();
  }

  void generateRandomColor() {
    randomR = random.nextInt(256);
    randomG = random.nextInt(256);
    randomB = random.nextInt(256);
  }

  void answerChooseHandler(int r, int g, int b) {
  if (r == randomR && g == randomG && b == randomB) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Correct"),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );

    setState(() {
      totalScore += 1;
      questionCount += 1;
      generateRandomColor();
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Wrong"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );

    setState(() {
      questionCount += 1;
      generateRandomColor();
    });
  }
}


  void resetHandler() {
    setState(() {
      totalScore = 0;
      questionCount = 0;
      generateRandomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: questionCount < 10
          ? Column(
              children: <Widget>[
                RGB(randomR, randomG, randomB),
                ColorOptions(randomR, randomG, randomB, answerChooseHandler),
              ],
            )
          : Result(
  score: totalScore,
  questions: questionCount,
  resetHandler: resetHandler,
),

    );
  }
}
