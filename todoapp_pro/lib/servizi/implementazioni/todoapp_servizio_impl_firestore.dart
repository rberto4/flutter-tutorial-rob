import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp_pro/model/todoapp_todo_modello.dart';
import 'package:todoapp_pro/servizi/todoapp_servizio_astratto.dart';

class TodoappServizioImplFirestore implements TodoAppServizioAstratto {
  // Riferimento alla collezione su Firestore
  final CollectionReference _db = FirebaseFirestore.instance.collection(
    'todos',
  );

 @override
  Stream<List<TodoappTodoModello>> streamDeiTodo() {
    // Trasforma il flusso di snapshot di Firestore in una lista di modelli
    return _db.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoappTodoModello.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  @override
  Future<void> aggiungiUnTodoAllaLista(TodoappTodoModello todo) {
    return _db.add(todo.toMap());
  }

  @override
  Future<void> rimuoviUnTodoDallaLista(String id) {
    return _db.doc(id).delete();
  }

  @override
  Future<void> aggiornaUnTodoDellaLista(
    String id,
    TodoappTodoModello todoNuovo,
  ) {
    return _db.doc(id).update(todoNuovo.toMap());
  }

  @override
  Future<void> completaUnTodoDellaLista(String id) async {
    final docRef = _db.doc(id);
    final doc = await docRef.get();
    if (doc.exists) {
      final bool currentState = doc.get('isDone') ?? false;
      await docRef.update({'isDone': !currentState});
    }
  }
}


// miglioramento: uso di Stream
// Lo stream è il nostro "contratto di osservazione"
/*
@override
  Stream<List<TodoappTodoModello>> streamDeiTodo() {
    // Trasforma il flusso di snapshot di Firestore in una lista di modelli
    return _db.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoappTodoModello.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  In questo modo, invece di dover chiamare un metodo per ottenere la lista dei todo ogni volta che vogliamo aggiornarla
  , possiamo semplicemente ascoltare lo stream e ricevere automaticamente gli aggiornamenti ogni volta che la lista dei todo cambia. 
  Questo rende il codice più reattivo e semplifica la gestione dello stato, perché non dobbiamo più preoccuparci di chiamare manualmente i metodi per aggiornare la
  lista dei todo ogni volta che facciamo una modifica. 
  Invece, possiamo semplicemente ascoltare lo stream e ricevere automaticamente gli aggiornamenti ogni volta che la lista dei todo cambia.
*/  
