import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class mySignUp extends StatefulWidget {
  const mySignUp({Key? key}) : super(key: key);

  @override
  _mySignUpState createState() => _mySignUpState();
}

class _mySignUpState extends State<mySignUp> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoApp'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            myTextField("Enter UserName", Icons.person_outline, false,
                _userNameTextController),
            const SizedBox(
              height: 20,
            ),
            myTextField("Enter Email id", Icons.person_outline, false,
                _emailTextController),
            const SizedBox(
              height: 30,
            ),
            myTextField("Enter Password", Icons.lock_outline, true,
                _passwordTextController),
            const SizedBox(
              height: 30,
            ),
            mySignInButton(context, false, () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text)
                  .then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignIn())))
                  .onError((error, stackTrace) =>
                  print("Error ${error.toString()}"));
            }),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
