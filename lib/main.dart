import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign_in.dart';
import 'todo_list_provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(    /* Change notifier  */
      create: (context) => TodoListProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sayari Areej',
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.grey[600],
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const SignIn(),
    );
  }
}
