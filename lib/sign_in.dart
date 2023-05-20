import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

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
            Image.asset(
              'images/enit.jpg',
              fit: BoxFit.fitWidth,
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            myTextField("Enter UserName", Icons.person_outline, false,
                _emailTextController),
            const SizedBox(
              height: 5,
            ),
            myTextField("Enter Password", Icons.lock_outline, true,
                _passwordTextController),
            const SizedBox(
              height: 10,
            ),
            mySignInButton(
                context,
                true,
                    () => FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text)
                    .then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage())))
                    .onError((error, stackTrace) =>
                    print("Error ${error.toString()}"))),
            const SizedBox(
              height: 10,
            ),
            mySignUpRow(context),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

TextField myTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    style: TextStyle(color: Colors.blue.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.blueAccent,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.blue.withOpacity(0.8)),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: Colors.blue.shade50,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container mySignInButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    //width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () => onTap(),
      child:  Text(
        isLogin ? 'Log In' : 'Sign Up',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
    ),
  );
}

Row mySignUpRow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have account?",
        style: TextStyle(color: Colors.blueAccent),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const mySignUp()));
        },
        child: const Text("Sign Up",
            style: TextStyle(
                color: Colors.lightBlue, fontWeight: FontWeight.bold)),
      )
    ],
  );
}
