import 'package:todoapp_pro/model/todoapp_tag_modello.dart';

class TodoappTodoModello {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final TodoappTagModello tag;

  TodoappTodoModello({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.tag,
  });

  // Sostituisce i valori di un Todo con quelli passati come argomento,
  // restituendo un nuovo Todo con i valori aggiornati.
  // come se fosse un costruttore, ma invece di creare un nuovo oggetto, prende un oggetto esistente e ne crea una copia con alcune modifiche.
  // come i metodi get e set, ma invece di modificare l'oggetto originale, restituisce un nuovo oggetto con le modifiche.

  TodoappTodoModello copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
    TodoappTagModello? tag,
  }) {
    return TodoappTodoModello(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      tag: tag ?? this.tag,
    );
  }
  // Questi metodi servono per convertire un oggetto Todo in una mappa (ad esempio, per salvarlo in un database)
  // e per creare un oggetto Todo a partire da una mappa (ad esempio,
  // quando recuperiamo i dati da un database, li otteniamo sotto forma di mappa,
  // e dobbiamo convertirli in oggetti Todo per poterli usare nella nostra app).

  factory TodoappTodoModello.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    final tagMap = map['tag'] as Map<String, dynamic>?;

    return TodoappTodoModello(
      id: documentId,
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      isDone: map['isDone'] == true,
      tag: TodoappTagModello.fromMap(
        tagMap ?? <String, dynamic>{},
        tagMap?['id']?.toString() ?? '',
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'tag': tag.toMap(),
    };
  }
}
