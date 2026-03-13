import 'package:flutter/material.dart';
import 'package:todoapp_pro/model/todoapp_todo_modello.dart';
import 'package:todoapp_pro/servizi/todoapp_servizio_astratto.dart';

class TodoappServizioImplementazione implements TodoAppServizioAstratto {

  // Lista in memoria dei todo, inizialmente solo con tutorial, verrà popolata con i dati ottenuti dal controller

  final List<TodoappTodoModello> _listaDeiTodo = <TodoappTodoModello>[
    TodoappTodoModello(
      id: UniqueKey().toString(),
      title: "Tutorial TodoApp 🤖",
      description: "Questo è un Todo di esempio creato per mostrare come funziona la nostra app. \n - Premi il tasto '+ Aggiungi' per creare un nuovo Todo,\n\ - Premi il tasto '🗑️' per rimuovere questo Todo di esempio.\n - Tieni premuto per modificare un Todo.",
    ),
  ];

  @override
  Future<void> aggiornaUnTodoDellaLista(
    String id,
    TodoappTodoModello todoNuovo,
  ) async {
    final indice = _listaDeiTodo.indexWhere((todo) => todo.id == id);
    if (indice == -1) {
      return;
    }
    _listaDeiTodo[indice] = todoNuovo.copyWith(id: id);
  }

  @override
  Future<void> aggiungiUnTodoAllaLista(TodoappTodoModello todo) async {
    _listaDeiTodo.add(todo);
  }

  @override
  Future<List<TodoappTodoModello>> ottieniListaDeiTodo() async {
    return List<TodoappTodoModello>.unmodifiable(_listaDeiTodo);
  }

  @override
  Future<void> rimuoviUnTodoDallaLista(String id) async {
    _listaDeiTodo.removeWhere((todo) => todo.id == id);
  }
  
  @override
  Future<void> completaUnTodoDellaLista(String id) async {
    _listaDeiTodo.where((todo) => todo.id == id).forEach((todo) {
      final indice = _listaDeiTodo.indexOf(todo);
      if (indice != -1) {
        _listaDeiTodo[indice] = todo.copyWith(isDone:  !_listaDeiTodo[indice].isDone);
      }
    });
  }
}