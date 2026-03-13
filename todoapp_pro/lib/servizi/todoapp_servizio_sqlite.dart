import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_pro/model/todoapp_todo_modello.dart';
import 'package:todoapp_pro/servizi/todoapp_servizio_astratto.dart';

class TodoappServizioSqlite implements TodoAppServizioAstratto {
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

  @override
  Future<List<TodoappTodoModello>> ottieniListaDeiTodo() async {
    final db = await _db;
    final rows = await db.query(_tableTodos, orderBy: 'rowid DESC');

    return rows.map(_mappaInTodo).toList(growable: false);
  }

  @override
  Future<void> aggiungiUnTodoAllaLista(TodoappTodoModello todo) async {
    final db = await _db;
    await db.insert(
      _tableTodos,
      _todoInMappa(todo),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> rimuoviUnTodoDallaLista(String id) async {
    final db = await _db;
    await db.delete(_tableTodos, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> aggiornaUnTodoDellaLista(
    String id,
    TodoappTodoModello todoNuovo,
  ) async {
    final db = await _db;
    final todoAggiornato = todoNuovo.copyWith(id: id);

    await db.update(
      _tableTodos,
      _todoInMappa(todoAggiornato),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> completaUnTodoDellaLista(String id) async {
    final db = await _db;
    final rows = await db.query(
      _tableTodos,
      columns: ['is_done'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) {
      return;
    }

    final bool valoreAttuale = (rows.first['is_done'] as int) == 1;

    await db.update(
      _tableTodos,
      {'is_done': valoreAttuale ? 0 : 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, Object?> _todoInMappa(TodoappTodoModello todo) {
    return {
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'is_done': todo.isDone ? 1 : 0,
    };
  }

  TodoappTodoModello _mappaInTodo(Map<String, Object?> mappa) {
    return TodoappTodoModello(
      id: mappa['id'] as String,
      title: mappa['title'] as String,
      description: mappa['description'] as String,
      isDone: (mappa['is_done'] as int) == 1,
    );
  }
}
