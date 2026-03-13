import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_pro/schermate/todoapp_homepage_schermata.dart';
import 'package:todoapp_pro/temi/todoapp_tema.dart';
import 'package:todoapp_pro/todoapp_provider.dart';

void main() {
  runApp(
     MultiProvider(
      providers: [
        // Aggiugo qui il mio provider
        // Si occuperà di creare un'istanza del controller e di fornirla a tutta l'app
        todoAppProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}
);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoapp Pro',
      theme: TodoappTema.tema,
      debugShowCheckedModeBanner: false,
      home: const TodoappHomepageSchermata(),
    );
  }
}
