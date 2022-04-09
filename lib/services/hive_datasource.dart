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
    Box box = await Hive.openBox<ToDo>('Todos_box');
    const List<ToDo> tList = [];
    box.addAll(tList);
  }

  @override
  Future<int> addTodo(ToDo t) async {
    Box box = await Hive.openBox<ToDo>('Todos_box');
    return await box.add(t);
  }

  @override
  Future<List<ToDo>> all() async {
    Box box = await Hive.openBox<ToDo>('Todos_box');
    return List.generate(box.length, (index) => box.get(index));
  }

  @override
  Future<int> deleteAll() async {
    Box box = await Hive.openBox<ToDo>('Todos_box');
    return await box.clear();
  }

  @override
  Future<int> deleteTodo(ToDo t) async {
    int result = 0;
    Box box = await Hive.openBox<ToDo>('Todos_box');
    box.delete(box.values.where((todo) => (todo as ToDo).id == t.id)).whenComplete(() => result = 1);
    return result;
  }

  @override
  Future<ToDo> getTodo(String _id) async {
    // Not the best implementation, but was unneccessary for the task anyway - wanted to try and see if I could.
    Box box = await Hive.openBox<ToDo>('Todos_box');
    return box.values.where((todo) => (todo as ToDo).id == _id) as ToDo;
  }

  @override
  Future<int> updateTodo(ToDo t) {
    throw UnimplementedError();
  }
}
