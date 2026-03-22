import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todoapp_pro/model/todoapp_todo_modello.dart';
import 'package:todoapp_pro/servizi/todoapp_servizio_astratto.dart';

class TodoappController extends ChangeNotifier {

  // Il controller è il "cervello" della nostra app, gestisce la logica e i dati
  // Il controller dipende da un servizio astratto, che gli fornisce i dati
  // In questo modo, il controller non dipende da una specifica implementazione del servizio,
  // rendendo il codice più modulare e testabile

  // Servizio astratto
  final TodoAppServizioAstratto servizio;
  
  List<TodoappTodoModello> _listaCompletaDeiTodo = [];
  List<TodoappTodoModello> _listaDeiTodo = [];
  String _testoFiltroCorrente = '';
  List<TodoappTodoModello> get listaDeiTodo => _listaDeiTodo;

  // StreamSubscription per chiudere l'ascolto quando il controller viene distrutto
  StreamSubscription? _subscription;
  TodoappController({required this.servizio}) {
    _inizializza();
  }

  // Controller della lista

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  void _inizializza() {
    // Ci mettiamo in ascolto dello stream definito nel servizio
    _subscription = servizio.streamDeiTodo().listen((nuovaLista) {
      final listaOrdinata = [...nuovaLista]
        ..sort((a, b) => a.isDone.toString().compareTo(b.isDone.toString())); // Ordina i todo in base allo stato
      _listaCompletaDeiTodo = listaOrdinata;
      _applicaFiltro(notifica: true);
    }, onError: (error) {
      print("Errore nello stream: $error");
    });
  }

  // I metodi CRUD ora non devono più chiamare "ottieniListaDeiTodo()"
  // perché Firestore aggiornerà lo stream automaticamente dopo l'azione.

  Future<void> aggiungiUnTodo(TodoappTodoModello todo) async {
    try {
      await servizio.aggiungiUnTodoAllaLista(todo);
    } catch (e) {
      print('Errore aggiungendo un todo: $e');
    }
  }

   Future<void> aggiornaUnTodo(String id, TodoappTodoModello todoNuovo) async {
    try {
      await servizio.aggiornaUnTodoDellaLista(id, todoNuovo);
    } catch (e) {
      print('Errore aggiornando un todo: $e');
    }
  }

  Future<void> rimuoviUnTodo(String id) async {
    try {
      await servizio.rimuoviUnTodoDallaLista(id);
    } catch (e) {
      print('Errore rimuovendo un todo: $e');
    }
  }

  Future<void> completaUnTodo(String id) async {
    try {
      await servizio.completaUnTodoDellaLista(id);
    } catch (e) {
      print('Errore completando un todo: $e');
    }
  }

  // Metodo per filtrare la lista dei todo in base a un testo di ricerca
  void filtraLaListaDeiTodo(String testo) {
    _testoFiltroCorrente = testo.trim();
    _applicaFiltro(notifica: true);
  }

  void _applicaFiltro({required bool notifica}) {
    // Il filtro è gestito nel controller perché è una logica di presentazione.
    if (_testoFiltroCorrente.isEmpty) {
      _listaDeiTodo = [..._listaCompletaDeiTodo];
    } else {
      final filtro = _testoFiltroCorrente.toLowerCase();
      _listaDeiTodo = _listaCompletaDeiTodo
          .where((todo) => todo.title.toLowerCase().contains(filtro))
          .toList();
    }

    if (notifica) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel(); // Importante: pulizia della memoria
    _scrollController.dispose(); // Pulizia del controller di scroll
    super.dispose();
  }
}