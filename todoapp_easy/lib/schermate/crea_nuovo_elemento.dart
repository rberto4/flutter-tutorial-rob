import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_easy/model/todo.dart';
import 'package:todoapp_easy/schermate/crea_nuovo_elemento.dart';

class CreaNuovoElemento extends StatefulWidget {
  const CreaNuovoElemento({super.key});

  @override
  State<CreaNuovoElemento> createState() => _CreaNuovoElementoState();
}

class _CreaNuovoElementoState extends State<CreaNuovoElemento> {
  // Attributi di classe
  // Lista di Todo che conterrà tutti i Todo creati dall'utente. Inizialmente è vuota
  Todo nuovoTodo = Todo(title: "", description: "");
  TextEditingController titoloController = TextEditingController();
  TextEditingController descrizioneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.bitcountSingleInk(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: const [
              TextSpan(
                text: 'Crea',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: ' ',
                style: TextStyle(color: Colors.redAccent),
              ),
              TextSpan(
                text: 'Nuovo',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              // Qui richiuamo il metodo per navigare alla schermata di creazione di un nuovo elemento.
              nuovoTodo.copyWith(title: "", description: "");
              titoloController.clear();
              descrizioneController.clear();

            },
            icon: const Icon(Icons.clear_all, color: Colors.black, size: 28,),
          )
        ],
      ),

      body: creaFormPerNuovoTodo(),

      floatingActionButton: tastoSalva(),
    );
  }

  void navigaVersoSchermataHome() {
    // Chiudiamo questa schermata restituendo il nuovo Todo al chiamante.
    Navigator.pop(context, nuovoTodo);
  }

  Widget creaFormPerNuovoTodo() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(  context).size.height * 0.1,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 5),
              right: BorderSide(color: Colors.black, width: 4),
            ),
          ),
          child: TextField(
            controller: titoloController,
             cursorColor: Colors.redAccent,
            decoration:  InputDecoration(
              labelText: 'Titolo ..',
               labelStyle: GoogleFonts.bitcountSingleInk(
                textStyle: const TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.bold ),
              ),
             border: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
            ),
             style: GoogleFonts.bitcountSingleInk(
              textStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold ),
            ),
            onChanged: (value) {
              setState(() {
                nuovoTodo = nuovoTodo.copyWith(title: value);
              });
            },
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(  context).size.height * 0.4,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 5),
              right: BorderSide(color: Colors.black, width: 4),
            ),
          ),
          child: TextField(
            controller: descrizioneController,
            cursorColor: Colors.redAccent,
            decoration:  InputDecoration(
              labelText: 'Descrizione ..',
              labelStyle: GoogleFonts.bitcountSingleInk(
                textStyle: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold ),
              ),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
            ),
            style: GoogleFonts.bitcountSingleInk(
              textStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold ),
            ),
            
             maxLines: null,
             expands: true,
             textAlignVertical: TextAlignVertical.top,
             
             onChanged: (value) {
              setState(() {
                nuovoTodo = nuovoTodo.copyWith(description: value);
              });
            },
            
          ),
        ),
      ],
    );
  }

  Widget tastoSalva() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.black, width: 5),
      ),

      elevation: 5,
      backgroundColor: Colors.green,

      onPressed: () {
        // Qui richiuamo il metodo per navigare alla schermata di creazione di un nuovo elemento.
        navigaVersoSchermataHome();
      },
      label: Text(
        "Salva",
        style: GoogleFonts.bitcountSingleInk(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      icon: const Icon(Icons.save, color: Colors.white),
    );
  }
}
