import 'dart:html';

import 'package:week4ex1/models/todo.dart';

import 'todo_datasource.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalSQLiteDatasource implements TodoDatasouce {
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
          'CREATE TABLE todos (id INTEGER PRIMARY KEY, name TEXT, description TEXT, complete INTEGER)');
      },
    );
    initalized = true;
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
  Future<bool> addTodo(ToDo t) async {
    return true;
  }

  @override
  Future<bool> deleteTodo(ToDo t) async {
    return true;
  }

  @override
  Future<ToDo> getTodo(int id) async {
    return ToDo(name: 'name', description: 'description', complete: false);
  }

  @override
  Future<bool> updateTodo(ToDo t) async {
    return true;
  }

}