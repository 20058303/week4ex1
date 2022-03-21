import 'package:week4ex1/models/todo.dart';

import 'todo_datasource.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class LocalSQLiteDatasource implements TodoDatasource {
  late Database database;
  bool initalized = false;

  LocalSQLiteDatasource() {
    init();
  }

  Future<void> init() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos (id INTEGER PRIMARY KEY AUTO_INCREMENT, name TEXT, description TEXT, complete INTEGER)');
      },
      version: 1,
    );
    initalized = true;
    print('initalized');
  }

  @override
  Future<List<ToDo>> all() async {
    if(!initalized) return <ToDo>[];
    List<Map<String, dynamic>> maps = await database.query('todos');
    return List.generate(maps.length, (i) {
      return ToDo(
        name: maps[i]['name'],
        description: maps[i]['description'],
        complete: maps[i]['complete'] == 0 ? false : true
      );
    });
  }

  @override
  Future<void> addTodo(ToDo t) async {
    if(initalized) {
      await database.insert(
        'todos',
        t.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
      print('$t -- yes');
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    if(initalized) {
      await database.delete(
        'todos',
        where: 'id = ?',
        whereArgs: [id]
      );
    }
  }

  @override
  Future<ToDo> getTodo(int id) async {
    final List<Map<String, dynamic>> l = await database.query('todos', where: 'id = ?', whereArgs: [id]);
    return ToDo(
      name: l[0]['name'],
      description: l[0]['description'],
      complete: l[0]['complete'],
    );
  }

  @override
  Future<void> updateTodo(ToDo t) async {
    if(initalized) {
      await database.update('todos', t.toMap(), where: 'id = ?', whereArgs: [t.id]);
    }
  }

}