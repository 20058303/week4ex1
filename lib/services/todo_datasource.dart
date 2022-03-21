import 'package:week4ex1/models/todo.dart';


abstract class TodoDatasource {
  Future<List<ToDo>> all();
  Future<void> addTodo(ToDo t);
  Future<void> deleteTodo(int id);
  Future<ToDo> getTodo(int id);
  Future<void> updateTodo(ToDo t);
}