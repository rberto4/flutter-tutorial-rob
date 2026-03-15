import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_pro/UI/appbar/todoapp_appbar.dart';
import 'package:todoapp_pro/UI/elementoTodo/todoapp_elementotodo.dart';
import 'package:todoapp_pro/UI/pulsanti/todoapp_pulsante.dart';
import 'package:todoapp_pro/controller/todoapp_controller.dart';
import 'package:todoapp_pro/model/todoapp_todo_modello.dart';
import 'package:todoapp_pro/schermate/todoapp_creazione_schermata.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoappHomepageSchermata extends StatelessWidget {
  const TodoappHomepageSchermata({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoappController>().listaDeiTodo;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: TodoappAppbar(titolo: 'TodoApp'),
      ),
      body: SafeArea(
        child: todos.isEmpty
            ? const Center(
                child: Text(
                  'Non ci sono todo!\naggiungine uno cliccando\nsul pulsante in basso (:',
                  style: TextStyle(fontSize: 18.0, color: TodoappColori.nero),
                  textAlign: TextAlign.center,
                ),
              )
            : _buildTodoList(context, todos),
      ),
      floatingActionButton: TodoAppPulsante(
        testo: 'Aggiungi',
        icona: Icons.add,
        coloreDiSfondo: TodoappColori.rosso,
        coloreDelTesto: TodoappColori.bianco,
        onPressed: () => {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const TodoappCreazioneSchermata(),
            ),
          ),
        },
      ),
    );
  }

  Widget _buildTodoList(BuildContext context, List<TodoappTodoModello> todos) {
    // 1. Creiamo le due sottoliste
    final nonCompletati = todos.where((t) => !t.isDone).toList();
    final completati = todos.where((t) => t.isDone).toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      children: [
        // --- SEZIONE NON COMPLETATI (con titolo opzionale) ---
        if (nonCompletati.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Non completati (${nonCompletati.length})",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TodoappColori.nero,
                fontSize: 18
              ),
            ),
          ),
          ...nonCompletati.map((todo) => _buildTodoItem(context, todo)),
        ],

        // --- SEPARATORE ---
        // Mostriamo il separatore solo se abbiamo sia incompleti che completati
        if (nonCompletati.isNotEmpty && completati.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(color: TodoappColori.nero, thickness: 3, radius: BorderRadius.all(Radius.circular(8.0)),),
          ),

        // --- SEZIONE COMPLETATI (con titolo opzionale) ---
        if (completati.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Completati (${completati.length})",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TodoappColori.nero,
                fontSize: 18
              ),
            ),
          ),
          ...completati.map((todo) => _buildTodoItem(context, todo)),

          SizedBox(height: 24.0), // Spazio extra alla fine della lista
        ],
      ],
    );
  }

  Widget _buildTodoItem(BuildContext context, TodoappTodoModello todo) {
    return TodoAppElementotodo(
      todo: todo,
      tocco: () => context.read<TodoappController>().completaUnTodo(todo.id),
      pressioneLunga: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) =>
              TodoappCreazioneSchermata(todoDaModificare: todo),
        ),
      ),
      pressioneCestino: () =>
          context.read<TodoappController>().rimuoviUnTodo(todo.id),
    );
  }

  void _cambiaStatoDiUnTodo(BuildContext context, String id) {
    context.read<TodoappController>().completaUnTodo(id);
  }

  void _eliminaUnTodo(BuildContext context, String id) {
    context.read<TodoappController>().rimuoviUnTodo(id);
  }
}
