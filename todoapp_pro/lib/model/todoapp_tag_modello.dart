class TodoappTagModello {
  final String id;
  final String tag;
  final String colore;

  TodoappTagModello({
    required this.id,
    required this.tag,
    required this.colore,
  });

  factory TodoappTagModello.fromMap(Map<String, dynamic> map, String documentId) {
    return TodoappTagModello(
      id: documentId,
      tag: map['tag'] ?? '',
      colore: map['colore'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tag': tag,
      'colore': colore,
    };
  }

 TodoappTagModello copywith({
    String? id,
    String? tag,
    String? colore,
  }) {
    return TodoappTagModello(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      colore: colore ?? this.colore,
    );
  }
}