import 'package:flutter/material.dart';
import 'package:todoapp_pro/UI/container/todoapp_container.dart';
import 'package:todoapp_pro/model/todoapp_todo_modello.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoAppElementotodo extends StatelessWidget {
  final TodoappTodoModello todo;
  final Function()? tocco;
  final Function()? pressioneLunga;
  final Function()? pressioneCestino;
  const TodoAppElementotodo({
    super.key,
    required this.todo,
    this.tocco,
    this.pressioneLunga,
    this.pressioneCestino,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TodoappContainer(
        coloreDiSfondo: todo.isDone
            ? TodoappColori.verde
            : TodoappColori.bianco,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              focusColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                tocco?.call();
              },
              onLongPress: () {
                pressioneLunga?.call();
              },
              // titolo del todo, con font personalizzato e stile
              title: Text(
                todo.title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: todo.isDone
                      ? TodoappColori.bianco
                      : TodoappColori.nero,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),

              // descrizione del todo, con font personalizzato e stile
              subtitle: Text(
                todo.description,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: todo.isDone
                      ? TodoappColori.bianco
                      : TodoappColori.grigio,
                ),
              ),
              leading: Transform.scale(
                scale: 1.2, // aumenta dimensione checkbox
                child: Checkbox(
                  checkColor: TodoappColori.bianco,
                  activeColor: TodoappColori.rosso,
                  side: BorderSide(color: Colors.black, width: 2),
                  value: todo.isDone,
                  onChanged: (value) {
                    tocco?.call();
                  },
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  pressioneCestino?.call();
                },
                icon: Icon(
                  Icons.delete,
                  color: todo.isDone
                      ? TodoappColori.bianco
                      : TodoappColori.nero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
