import 'package:week4ex1/models/todo.dart';

abstract class TodoDatasource {
  Future<List<ToDo>> all();
  Future<bool> addTodo(ToDo t);
  Future<bool> deleteTodo(ToDo t);
  Future<ToDo> getTodo(int id);
  Future<void> updateTodo(ToDo t);
}
