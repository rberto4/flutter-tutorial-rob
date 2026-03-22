import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_pro/UI/container/todoapp_container.dart';
import 'package:todoapp_pro/UI/textfield/todoapp_textfield.dart';
import 'package:todoapp_pro/controller/todoapp_controller.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoappSearchbar extends StatelessWidget {
  const TodoappSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: TodoappContainer(
              coloreDiSfondo: TodoappColori.rosso,
              child: IconButton(
                icon: Icon(Icons.search, color: TodoappColori.bianco),
                onPressed: () {
                  // premo e attivo la ricerca 
                  
                },
              ),
            ),
          ),
          Expanded(
            child: TodoappContainer(
              child: TodoappTextfield(
                label: 'Cerca...',
                onChanged: (testo) {
                  context.read<TodoappController>().filtraLaListaDeiTodo(testo);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
