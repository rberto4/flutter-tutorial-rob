import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_easy/model/todo.dart';
import 'package:todoapp_easy/schermate/crea_nuovo_elemento.dart';

class Homepage extends StatefulWidget {
  final List<Todo>? listaDiTodo;
  final Todo? todoNuovo;
  const Homepage({super.key, this.listaDiTodo, this.todoNuovo});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Lista di Todo locale
  // posso specificare il tipo di dato della lista, in questo caso List<Todo>,
  //inizializzarla come una lista vuota con growable: true, che permette di aggiungere elementi alla lista in seguito.
  late List<Todo> listaDiTodo = List<Todo>.empty(growable: true);

  // init state viene chiamato in automatico una sola volta quando il widget viene creato,
  //ed è il posto ideale per inizializzare la nostra lista di Todo.

  @override
  void initState() {
    super.initState();
    // inizializziamo la lista locale copiando eventuale lista passata

    if (widget.listaDiTodo != null) {
      listaDiTodo = List<Todo>.from(widget.listaDiTodo!);
    } else {
      listaDiTodo = <Todo>[];
    }
    // aggiungiamo il nuovo Todo se presente
    if (widget.todoNuovo != null) {
      listaDiTodo.add(widget.todoNuovo!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        automaticallyImplyActions: false,
        automaticallyImplyLeading: false,

        // widget particolare per creare titolo con 2 colori
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.bitcountSingleInk(
              textStyle: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: const [
              TextSpan(
                text: 'Todo',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'App',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.amber,
      ),

      body: listaDelleTodo(),

      floatingActionButton: tastoAggiungi(),
    );
  }

  // FUNZIONI E WIDGET --------------------
  Widget tastoAggiungi() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 5),
          right: BorderSide(color: Colors.black, width: 5),
        ),
      ),
      child: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),

        elevation: 5,
        backgroundColor: Colors.redAccent,

        onPressed: () {
          // Qui richiuamo il metodo per navigare alla schermata di creazione di un nuovo elemento.
          navigaVersoSchermataCreazione();
        },
        label: Text(
          "Aggiungi",
          style: GoogleFonts.bitcountSingleInk(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget listaDelleTodo() {
    return ListView.builder(
      itemCount: listaDiTodo.length,
      itemBuilder: (context, index) {
        final todo = listaDiTodo[index];
        return elementoDellaTodo(todo, index);
      },
    );
  }

  Widget elementoDellaTodo(Todo todo, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: todo.isDone ? Colors.green : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 5),
          right: BorderSide(color: Colors.black, width: 4),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            titleAlignment: ListTileTitleAlignment.top,
            focusColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              setState(() {
                listaDiTodo[index] = listaDiTodo[index].copyWith(
                  isDone: !listaDiTodo[index].isDone,
                );
              });
            },
            onLongPress: () {
              // Naviga alla schermata di creazione passando il Todo da modificare.
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) =>
                      CreaNuovoElemento(todoDaModificare: todo),
                ),
              ).then((todoModificato) {
                if (todoModificato != null) {
                  setState(() {
                    listaDiTodo[index] = todoModificato;
                  });
                }
              });
            },
            // titolo del todo, con font personalizzato e stile
            title: Text(
              todo.title,
              style: GoogleFonts.bitcountSingleInk(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: todo.isDone ? Colors.white : Colors.black,
                ),
              ),
            ),

            // descrizione del todo, con font personalizzato e stile
            subtitle: Text(
              todo.description,
              style: GoogleFonts.bitcountSingleInk(
                textStyle: const TextStyle(fontSize: 16),
                color: todo.isDone ? Colors.white : Colors.black,
              ),
            ),
            leading: Transform.scale(
              scale: 1.2, // aumenta dimensione checkbox
              child: Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.redAccent,
                side: BorderSide(color: Colors.black, width: 2),
                value: todo.isDone,
                onChanged: (value) {
                  setState(() {
                    listaDiTodo[index] = listaDiTodo[index].copyWith(
                      isDone: value,
                    );
                  });
                },
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  listaDiTodo.removeAt(index);
                });
              },
              icon: Icon(
                Icons.delete,
                color: todo.isDone ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // METODI -------------------------------
  void navigaVersoSchermataCreazione() async {
    // Apriamo la schermata di creazione e aspettiamo il Todo restituito.
    final Todo? nuovo = await Navigator.push<Todo?>(
      context,
      CupertinoPageRoute(builder: (context) => const CreaNuovoElemento()),
    );

    // Se l'utente ha salvato un Todo (non ha annullato), lo aggiungiamo.
    if (nuovo != null) {
      setState(() {
        listaDiTodo.add(nuovo);
      });
    }
  }
}
