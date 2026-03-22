

/*
class TodoappServizioImplSqlite implements TodoAppServizioAstratto {
  static const String _databaseName = 'todoapp.db';
  static const int _databaseVersion = 1;
  static const String _tableTodos = 'todos';

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    }
    _database = await _inizializzaDatabase();
    return _database!;
  }

  Future<Database> _inizializzaDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableTodos (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            is_done INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }
  
  final _streamController = StreamController<List<TodoappTodoModello>>.broadcast();

  // Metodo privato per leggere dal DB e spingere nello stream
  Future<void> _aggiornaStream() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(_tableTodos);
    
    final lista = maps.map((m) => TodoappTodoModello(
      id: m['id'],
      title: m['title'],
      description: m['description'],
      isDone: m['is_done'] == 1,
    )).toList();
    
    _streamController.add(lista);
  }

  @override
  Stream<List<TodoappTodoModello>> streamDeiTodo() {
    _aggiornaStream(); // Carica i dati la prima volta che qualcuno ascolta
    return _streamController.stream;
  }

  @override
  Future<void> aggiungiUnTodoAllaLista(TodoappTodoModello todo) async {
    final db = await _db;
    await db.insert(_tableTodos, {
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'is_done': todo.isDone ? 1 : 0,
    });
    await _aggiornaStream(); // Notifica il cambiamento
  }

  @override
  Future<void> completaUnTodoDellaLista(String id) async {
    final db = await _db;
    // Logica toggle: legge lo stato attuale e lo inverte
    final res = await db.query(_tableTodos, where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      int nuovoStato = res.first['is_done'] == 1 ? 0 : 1;
      await db.update(_tableTodos, {'is_done': nuovoStato}, where: 'id = ?', whereArgs: [id]);
      await _aggiornaStream();
    }
  }

  @override
  Future<void> rimuoviUnTodoDallaLista(String id) async {
    final db = await _db;
    await db.delete(_tableTodos, where: 'id = ?', whereArgs: [id]);
    await _aggiornaStream();
  }
  
  @override
  Future<void> aggiornaUnTodoDellaLista(String id, TodoappTodoModello todoNuovo) async {
    final db = await _db;
    await db.update(_tableTodos, {
      'title': todoNuovo.title,
      'description': todoNuovo.description,
      'is_done': todoNuovo.isDone ? 1 : 0,
    }, where: 'id = ?', whereArgs: [id]);
    await _aggiornaStream();
  }
 
}

*/