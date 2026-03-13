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
      title: 'TodoApp Easy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      debugShowCheckedModeBanner: false,
      home: Homepage(
        listaDiTodo: const [],
        todoNuovo: Todo(
          title: "Tutorial TodoApp 🤖",
          description: "Questo è un Todo di esempio creato per mostrare come funziona la nostra app. \n - Premi il tasto '+ Aggiungi' per creare un nuovo Todo,\n\ - Premi il tasto '🗑️' per rimuovere questo Todo di esempio.\n - Tieni premuto per modificare un Todo.",
        )
        ),
    );
  }
}


