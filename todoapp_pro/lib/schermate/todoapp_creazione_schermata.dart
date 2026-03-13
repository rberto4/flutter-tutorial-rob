import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_pro/UI/appbar/todoapp_appbar.dart';
import 'package:todoapp_pro/UI/container/todoapp_container.dart';
import 'package:todoapp_pro/UI/pulsanti/todoapp_pulsante.dart';
import 'package:todoapp_pro/UI/textfield/todoapp_textfield.dart';
import 'package:todoapp_pro/controller/todoapp_controller.dart';
import 'package:todoapp_pro/model/todoapp_todo_modello.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoappCreazioneSchermata extends StatefulWidget {
  final TodoappTodoModello? todoDaModificare;

  const TodoappCreazioneSchermata({super.key, this.todoDaModificare});

  @override
  State<TodoappCreazioneSchermata> createState() =>
      _TodoappCreazioneSchermataState();
}

class _TodoappCreazioneSchermataState extends State<TodoappCreazioneSchermata> {
  late final TextEditingController titoloController;
  late final TextEditingController descrizioneController;

  @override
  void initState() {
    super.initState();
    titoloController = TextEditingController();
    descrizioneController = TextEditingController();

    if (widget.todoDaModificare != null) {
      titoloController.text = widget.todoDaModificare!.title;
      descrizioneController.text = widget.todoDaModificare!.description;
    }
  }

  @override
  void dispose() {
    titoloController.dispose();
    descrizioneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool inModifica = widget.todoDaModificare != null;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: TodoappAppbar(
          titolo: inModifica ? 'Modifica todo' : 'Crea nuovo',
           mostraFrecciaIndietro: true,
           azioni: [
              IconButton(
                icon: const Icon(Icons.clear_all, color: TodoappColori.rosso, size: 36,),
                onPressed: () {
                  titoloController.clear();
                  descrizioneController.clear();
                },
              ),
           ],
          ),
      ),
      body: _buildForm(context, titoloController, descrizioneController),
      floatingActionButton: TodoAppPulsante(
        testo: inModifica ? 'Aggiorna' : 'Salva',
        icona: Icons.save,
        coloreDiSfondo: inModifica ? TodoappColori.arancio : TodoappColori.verde,
        coloreDelTesto: TodoappColori.bianco,
        onPressed: () async {
          await _salvaTodo(
            context,
            titoloController.text,
            descrizioneController.text,
          );
          if (mounted) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }


  Widget _buildForm(BuildContext context, TextEditingController titoloController, TextEditingController descrizioneController) {

  
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            child: TodoappContainer(
              child: TodoappTextfield(
                controller: titoloController,
                label: 'Titolo ..',
                labelColor: TodoappColori.rosso,
                coloreDelTesto: TodoappColori.nero,
                
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: TodoappContainer(
              child: TodoappTextfield(
                controller: descrizioneController,
                label: 'Descrizione ..',
                labelColor: TodoappColori.nero,
                coloreDelTesto: TodoappColori.grigio,
                
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _salvaTodo(
    BuildContext context,
    String titolo,
    String descrizione,
  ) async {
    final controller = context.read<TodoappController>();

    if (widget.todoDaModificare != null) {
      final todoAggiornato = widget.todoDaModificare!.copyWith(
        title: titolo,
        description: descrizione,
      );
      await controller.aggiornaUnTodoDellaLista(
        widget.todoDaModificare!.id,
        todoAggiornato,
      );
      return;
    }

    final nuovoTodo = TodoappTodoModello(
      id: UniqueKey().toString(),
      title: titolo,
      description: descrizione,
    );

    await controller.aggiungiUnTodoAllaLista(nuovoTodo);
  }
}
