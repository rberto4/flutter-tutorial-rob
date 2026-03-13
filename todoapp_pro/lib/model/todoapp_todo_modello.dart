class TodoappTodoModello {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  TodoappTodoModello({
    required this.id,
    required this.title,
    required this.description, 
    this.isDone = false, 
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
  }) {
    return TodoappTodoModello(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone
    );
  }
}