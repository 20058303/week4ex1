import 'package:week4ex1/models/todo.dart';

abstract class TodoDatasource {
  Future<List<ToDo>> all();
  Future<int> addTodo(ToDo t);
  Future<int> deleteTodo(ToDo t);
  Future<int> deleteAll();
  Future<ToDo> getTodo(String id);
  Future<int> updateTodo(ToDo t);
}
