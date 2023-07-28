import 'package:notes/modal/NoteModal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteService {
  open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    final database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, description TEXT)');
    });
    return database;
  }

  Future saveNote(title, note) async {
    final db = await open();
    await db.insert('notes', {'title': title, 'description': note});
    return true;
  }

  Future<List<TodoModal>?> getTodos() async {
    final db = await open();
    List<dynamic> list =
        await db.rawQuery('SELECT * FROM notes ORDER BY id DESC');
    if (list.length > 0) {
      var returnresponse = list.map((e) => TodoModal.fromJson(e)).toList();
      return returnresponse;
    } else {
      return null;
    }
  }

  Future updateTodo(id, title, note) async {
    final db = await open();
    db.update('notes', {'title': title, 'description': note},
        where: 'id = ?', whereArgs: [id]);
    return true;
  }

  Future deleteNote(id) async {
    final db = await open();
    int tid = int.parse(id);
    await db.rawDelete('DELETE FROM notes WHERE id = ?', [tid]);
    return true;
  }

  Future allTodos() async {
    final db = await open();
    var list = await db.rawQuery('SELECT * FROM notes');
    return list;
  }
}
