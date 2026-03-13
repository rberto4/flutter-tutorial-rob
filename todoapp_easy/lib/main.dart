import 'package:flutter/material.dart';
import 'package:todoapp_easy/model/todo.dart';
import 'package:todoapp_easy/schermate/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Homepage(
        listaDiTodo: const [],
        todoNuovo: Todo(
          title: "Todo di esempio",
          description: "Questo è un Todo di esempio creato per mostrare come funziona la nostra app. Premi il tasto + Aggiungi ",
        )
        ),
    );
  }
}


