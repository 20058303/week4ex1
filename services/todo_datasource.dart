import 'package:week4ex1/models/todo.dart';


abstract class TodoDatasouce {
  Future<List<ToDo>> all();
  Future<bool> addTodo(ToDo t);
  Future<bool> deleteTodo(ToDo t);
  Future<ToDo> getTodo(int id);
  Future<bool> updateTodo(ToDo t);
}