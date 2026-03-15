import 'package:todoapp_pro/model/todoapp_todo_modello.dart';


// Questo è il servizio astratto, 
// che definisce i metodi che il controller utilizzerà per interagire con i dati
// In questo modo, il controller non dipende da una specifica implementazione del servizio,
// ma solo da un'interfaccia, rendendo il codice più modulare e testabile

// non ci interessa COME il servizio ottiene i dati, 
// se da una lista in memoria, da un database, da un'api etc.

// Il controller si occuperà di chiamare questi metodi per ottenere, 
//aggiungere, rimuovere e aggiornare i todo,

abstract class TodoAppServizioAstratto {

  // Questi sono i metodi che il controller utilizzerà per interagire con i dati
  Stream<List<TodoappTodoModello>> streamDeiTodo();
  Future<void> aggiungiUnTodoAllaLista(TodoappTodoModello todo);
  Future<void> rimuoviUnTodoDallaLista(String id);
  Future<void> aggiornaUnTodoDellaLista(String id, TodoappTodoModello todoNuovo);
  Future<void> completaUnTodoDellaLista(String id);
}


// miglioramento: uso di Stream
// Lo stream è il nostro "contratto di osservazione"
// 
// Stream<List<TodoappTodoModello>> streamDeiTodo();
//
// In questo modo, invece di dover chiamare un metodo per ottenere la lista dei todo ogni volta che vogliamo aggiornarla,
// possiamo semplicemente ascoltare lo stream e ricevere automaticamente gli aggiornamenti ogni volta che la lista dei todo cambia. 
// Questo rende il codice più reattivo e semplifica la gestione dello stato, perché non dobbiamo più preoccuparci di chiamare manualmente 
// i metodi per aggiornare la lista dei todo ogni volta che facciamo una modifica. 
// Invece, possiamo semplicemente ascoltare lo stream e ricevere automaticamente gli aggiornamenti ogni volta che la lista dei todo cambia.
