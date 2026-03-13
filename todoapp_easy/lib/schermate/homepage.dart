import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_easy/model/todo.dart';
import 'package:todoapp_easy/schermate/crea_nuovo_elemento.dart';

class Homepage extends StatefulWidget {
  final List<Todo>? listaDiTodo;
  final Todo? todoNuovo;
  Homepage({super.key, this.listaDiTodo, this.todoNuovo});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Lista di Todo locale, sempre growable
  late List<Todo> listaDiTodo;

  @override
  void initState() {
    super.initState();
    // inizializziamo la lista locale copiando eventuale lista passata
    listaDiTodo = widget.listaDiTodo != null
        ? List<Todo>.from(widget.listaDiTodo!)
        : <Todo>[
                   ];

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
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.bitcountSingleInk(
              textStyle: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: const [
              TextSpan(text: 'Todo', style: TextStyle(color: Colors.black)),
              TextSpan(text: 'App', style: TextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.amber,
      ),

      body: creaListaDiTodo(),

      floatingActionButton: tastoAggiungi(),
    );
  }

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

  Widget tastoAggiungi() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.black, width: 5),
      ),

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
    );
  }

  Widget creaListaDiTodo() {
    return ListView.builder(
      itemCount: listaDiTodo.length,
      itemBuilder: (context, index) {
        final todo = listaDiTodo[index];
        return elementoDiTodo(todo, index);
      },
    );
  }

  void cambiaStatoDelTodo(int index) {
    setState(() {
      listaDiTodo[index] = listaDiTodo[index].copyWith(
        isDone: !listaDiTodo[index].isDone,
      );
    });
  }

  Widget elementoDiTodo(Todo todo, int index) {
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onTap: () {
              cambiaStatoDelTodo(index);
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
                  cambiaStatoDelTodo(index);
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
              icon:  Icon(
                Icons.delete, 
                color: todo.isDone ? Colors.white : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
