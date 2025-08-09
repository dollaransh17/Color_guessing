import 'package:flutter/material.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void _trySignup() {
    if (_formKey.currentState!.validate()) {
      // Signup logic here
      Navigator.pop(context); // back to login page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (val) => val != null && val.contains('@')
                    ? null
                    : 'Enter a valid email',
                onChanged: (val) => email = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (val) => val != null && val.length >= 6
                    ? null
                    : 'Password must be 6+ chars',
                onChanged: (val) => password = val,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _trySignup, child: Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
