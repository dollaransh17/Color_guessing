import 'package:flutter/material.dart';
import 'dart:math';

import './random-rgb.dart';
import './color_options.dart';
import './result.dart';

// Login Page Widget
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  void _tryLogin() {
    if (_formKey.currentState!.validate()) {
      // Here you can add actual authentication logic

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Color Guessing Game'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : 'Enter username',
                onChanged: (val) => username = val,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (val) => val != null && val.length >= 6
                    ? null
                    : 'Password must be 6+ chars',
                onChanged: (val) => password = val,
              ),
              const SizedBox(height: 32),
              ElevatedButton(onPressed: _tryLogin, child: const Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}

// Main entry point
void main() {
  runApp(const MyApp(home: LoginPage()));
}

// Main app widget accepting the home widget
class MyApp extends StatelessWidget {
  final Widget home;
  const MyApp({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Guessing Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: home,
    );
  }
}

// The main game page
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
        const SnackBar(
          content: Text("Correct"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      setState(() {
        totalScore += 1;
        questionCount += 1;
        generateRandomColor();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
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
      appBar: AppBar(title: Text(widget.title)),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // close drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (ctx) => const LoginPage()),
                );
              },
            ),
          ],
        ),
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
