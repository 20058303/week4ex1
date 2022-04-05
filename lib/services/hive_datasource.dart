import 'package:hive_flutter/hive_flutter.dart';
import 'package:week4ex1/models/todo.dart';
import 'package:week4ex1/services/todo_datasource.dart';

class LocalHiveDataSource implements TodoDatasource {
  LocalHiveDataSource() {
    init();
  }

  Future<void> init() async {
    Hive.registerAdapter(ToDoAdapter());
    await Hive.initFlutter();
    Box box = await Hive.openBox('Todos_box');
    const List<ToDo> t_list = [];
    box.addAll(t_list);
  }

  @override
  Future<int> addTodo(ToDo t) async {
    Box box = await Hive.openBox('Todos_box');
    return await box.add(t);
  }

  @override
  Future<List<ToDo>> all() async {
    Box box = await Hive.openBox('Todos_box');
    return List.generate(box.length, (index) => box.get(index));
  }

  @override
  Future<int> deleteAll() async {
    Box box = await Hive.openBox('Todos_box');
    return await box.clear();
  }

  @override
  Future<int> deleteTodo(ToDo t) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<ToDo> getTodo(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<int> updateTodo(ToDo t) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
