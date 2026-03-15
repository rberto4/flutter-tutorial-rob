import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_pro/firebase_options.dart';
import 'package:todoapp_pro/schermate/todoapp_homepage_schermata.dart';
import 'package:todoapp_pro/temi/todoapp_tema.dart';
import 'package:todoapp_pro/todoapp_provider.dart';

// Future serve per indicare che questa funzione è asincrona, 
// e che potrebbe impiegare del tempo per completarsi (ad esempio, se stiamo caricando dati da un database o da internet).

Future<void> main() async{
  // 1. Prima di tutto, assicuriamoci che Flutter sia inizializzato
  WidgetsFlutterBinding.ensureInitialized(); 

   // 2. Inizializza Firebase con le opzioni specifiche per la piattaforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
