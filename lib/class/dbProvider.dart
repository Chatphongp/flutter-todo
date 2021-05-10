import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    print('init db');
    String path = join(await getDatabasesPath(), "todo.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print('on create');

      try {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS todo (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          done INTEGER
        );
      ''');

        print('done init');
      } catch (err) {
        print('error');
        print(err);
      }
    });
  }

  newTodo(Todo t) async {
    final db = await database;
    var r = await db.insert("todo", t.toJson());
    return r;
  }

  deleteTodo(Todo t) async {
    final db = await database;
    var r =  await db.rawDelete('DELETE FROM todo WHERE id = ?', [t.id]);
    return r;
  }

  toggleTodo(Todo t) async {
    if (t.done > 0) {
      t.done = 0;
    } else {
      t.done = 1;
    }

    final db = await database;
    var r = await db.update('todo', t.toJsonWithId(), where:  'id = ?', whereArgs: [t.id]);
    return r;
  }

  Future<List<Todo>> getAllTodo() async {
    final db = await database;
    List<Todo> list = [];
    var r = await db.rawQuery("SELECT * FROM todo;");
    list = r.isNotEmpty
        ? r.toList().map((json) => Todo.fromJSON(json)).toList()
        : [];
    return list;
  }
}
