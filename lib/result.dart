import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final int questions;
  final VoidCallback resetHandler;

  // Correct constructor with named parameters and required annotations
  const Result({
    Key? key,
    required this.score,
    required this.questions,
    required this.resetHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Your score is', style: TextStyle(fontSize: 22)),
          Text('$score out of $questions', style: TextStyle(fontSize: 22)),
          TextButton(
            onPressed: resetHandler,
            child: Text(
              'RESTART',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
