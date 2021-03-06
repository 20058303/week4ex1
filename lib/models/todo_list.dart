import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:week4ex1/models/todo.dart';

class ToDoList extends ChangeNotifier {
  final List<ToDo> _todos = [];
  
  UnmodifiableListView<ToDo> get todos => UnmodifiableListView(_todos);

  int get todoCount {
    int c = 0;
    for (var _t in _todos) {
      if (_t.complete == false) {
        c++;
      }
    }
    print('take 1');
    return c;
  }

  void addToDo(ToDo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateToDo(ToDo todo) {
    ToDo listTodo = _todos.firstWhere((t) => t.name == todo.name);
    listTodo = todo;
    notifyListeners();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
  }

  void removeToDo(ToDo todo) {
    _todos.remove(todo);
    notifyListeners();
  }
}