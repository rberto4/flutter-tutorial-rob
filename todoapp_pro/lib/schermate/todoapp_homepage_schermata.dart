import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_pro/UI/appbar/todoapp_appbar.dart';
import 'package:todoapp_pro/UI/elementoTodo/todoapp_elementotodo.dart';
import 'package:todoapp_pro/UI/pulsanti/todoapp_pulsante.dart';
import 'package:todoapp_pro/controller/todoapp_controller.dart';
import 'package:todoapp_pro/schermate/todoapp_creazione_schermata.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoappHomepageSchermata extends StatelessWidget {
  const TodoappHomepageSchermata({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: TodoappAppbar(titolo: 'TodoApp'),
      ),
      body: _buildTodoList(context),
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

  Widget _buildTodoList(BuildContext context) {
    final todos = context.watch<TodoappController>().listaDeiTodo;

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoAppElementotodo(
          todo: todos[index],
          tocco: () {
            _cambiaStatoDiUnTodo(context, todos[index].id);
          },
          pressioneLunga: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => TodoappCreazioneSchermata(
                  todoDaModificare: todos[index],
                ),
              ),
            );
          },
          pressioneCestino: () {
            _eliminaUnTodo(context, todos[index].id);
          },
        );
      },
    );
  }

  void _cambiaStatoDiUnTodo(BuildContext context, String id) {
    context.read<TodoappController>().completaUnTodoDellaLista(id);
  }

  void _eliminaUnTodo(BuildContext context, String id) {
    context.read<TodoappController>().rimuoviUnTodoDallaLista(id);
  }
}
