import 'package:flutter/material.dart';
import 'package:todoapp_pro/model/todoapp_todo_modello.dart';
import 'package:todoapp_pro/servizi/todoapp_servizio_astratto.dart';

class TodoappController extends ChangeNotifier {
  // Dipendenze ----
  final TodoAppServizioAstratto servizio;

  // Costruttore ----
  TodoappController({required this.servizio});

  // Variabili di stato ----

  // Lista dei todo, inizialmente solo con tutorial
  // verrà popolata con i dati ottenuti dal servizio
  List<TodoappTodoModello> _listaDeiTodo = List<TodoappTodoModello>.empty(growable: true);
  List<TodoappTodoModello> get listaDeiTodo => _listaDeiTodo;

  // Metodi CRUD ----

  // Ottiene la lista dei todo tramite il servizio
  
  Future<void> ottieniListaDeiTodo() async {
    try {
      // Ottengo la lista dei todo dal servizio
      final lista = await servizio.ottieniListaDeiTodo();
      // Aggiorno la variabile di stato con la lista ottenuta
      _listaDeiTodo = lista;
      // Notifico i listener che lo stato è cambiato
      notifyListeners();
    } catch (e) {
      // Gestisco eventuali errori
      print('Errore nell\'ottenere la lista dei todo: $e');
    }
  }

  // Aggiunge un nuovo todo alla lista tramite il servizio

  Future<void> aggiungiUnTodoAllaLista(TodoappTodoModello todo) async {
    try {
      // Aggiungo un nuovo todo alla lista tramite il servizio
      await servizio.aggiungiUnTodoAllaLista(todo);
      // Dopo aver aggiunto, ottengo la lista aggiornata
      await ottieniListaDeiTodo();
    } catch (e) {
      // Gestisco eventuali errori
      print('Errore nell\'aggiungere un todo: $e');
    }
  }

  // Rimuove un todo dalla lista tramite il servizio

  Future<void> rimuoviUnTodoDallaLista(String id) async {
    try {
      // Rimuovo un todo dalla lista tramite il servizio
      await servizio.rimuoviUnTodoDallaLista(id);
      // Dopo aver rimosso, ottengo la lista aggiornata
      await ottieniListaDeiTodo();
    } catch (e) {
      // Gestisco eventuali errori
      print('Errore nel rimuovere un todo: $e');
    }
  }

  // Aggiorna un todo della lista tramite il servizio

  Future<void> aggiornaUnTodoDellaLista(String id, TodoappTodoModello todoNuovo) async {
    try {
      // Aggiorno un todo della lista tramite il servizio
      await servizio.aggiornaUnTodoDellaLista(id, todoNuovo);
      // Dopo aver aggiornato, ottengo la lista aggiornata
      await ottieniListaDeiTodo();
    } catch (e) {
      // Gestisco eventuali errori
      print('Errore nell\'aggiornare un todo: $e');
    }
  }

  // Cambia lo stato di completamento di un todo tramite il servizio
  Future<void> completaUnTodoDellaLista(String id) async {
    try {
      await servizio.completaUnTodoDellaLista(id);
      await ottieniListaDeiTodo();
    } catch (e) {
      print('Errore nel completare un todo: $e');
    }
  }
}
