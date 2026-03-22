
/*
class TodoappServizioImplMemoria implements TodoAppServizioAstratto {
  // La nostra lista "sorgente"
  final List<TodoappTodoModello> _listaInterna = [];

  // Lo StreamController che trasmette la lista
  // .broadcast() permette a più listener di ascoltare contemporaneamente
  final _controller = StreamController<List<TodoappTodoModello>>.broadcast();

  TodoappServizioImplMemoria() {
    // Aggiungiamo il tutorial iniziale
    _listaInterna.add(TodoappTodoModello(
      id: "1",
      title: "Tutorial TodoApp 🤖",
      description: "Esempio in memoria locale.",
    ));
    // Inviamo la lista iniziale allo stream
    _controller.add(List.unmodifiable(_listaInterna));
  }

  @override
  Stream<List<TodoappTodoModello>> streamDeiTodo() => _controller.stream;

  @override
  Future<void> aggiungiUnTodoAllaLista(TodoappTodoModello todo) async {
    _listaInterna.add(todo);
    _controller.add(List.unmodifiable(_listaInterna)); // Notifichiamo lo stream
  }

  @override
  Future<void> rimuoviUnTodoDallaLista(String id) async {
    _listaInterna.removeWhere((t) => t.id == id);
    _controller.add(List.unmodifiable(_listaInterna));
  }

  @override
  Future<void> completaUnTodoDellaLista(String id) async {
    final index = _listaInterna.indexWhere((t) => t.id == id);
    if (index != -1) {
      _listaInterna[index] = _listaInterna[index].copyWith(isDone: !_listaInterna[index].isDone);
      _controller.add(List.unmodifiable(_listaInterna));
    }
  }

  @override
  Future<void> aggiornaUnTodoDellaLista(String id, TodoappTodoModello todoNuovo) async {
    final index = _listaInterna.indexWhere((t) => t.id == id);
    if (index != -1) {
      _listaInterna[index] = todoNuovo;
      _controller.add(List.unmodifiable(_listaInterna));
    }
  }
}

*/