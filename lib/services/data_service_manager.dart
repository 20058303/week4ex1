import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:week4ex1/models/todo.dart';
import 'package:week4ex1/services/hive_datasource.dart';
import 'package:week4ex1/services/sqlite_datasource.dart';
import 'package:week4ex1/services/todo_datasource.dart';
import 'package:week4ex1/services/todo_remote_api_datasource.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;


class DataServiceManager implements TodoDatasource {
  late final TodoDatasource _local;
  final TodoDatasource _remote = ToDoRemoteAPIDatasource();

  DataServiceManager () {
    if(kIsWeb) {
      _local = LocalHiveDataSource();
    } else {
      _local = LocalSQLiteDatasource();
    }
  }

  Future<bool> _checkConnectivity() async {
    if ((kIsWeb && html.window.navigator.onLine == false) ||
      await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        return false;
    }
    return true;
  }

  @override
  Future<int> addTodo(ToDo t) async {
    return await _checkConnectivity()
      ? await _remote.addTodo(t)
      : await _local.addTodo(t);
  }

  @override
  Future<List<ToDo>> all() async {
    return await _checkConnectivity()
      ? await _remote.all()
      : await _local.all();
  }

  @override
  Future<int> deleteAll() async {
    return await _checkConnectivity()
      ? await _remote.deleteAll()
      : await _local.deleteAll();
  }

  @override
  Future<int> deleteTodo(ToDo t) async {
    return await _checkConnectivity()
      ? await _remote.deleteTodo(t)
      : await _local.deleteTodo(t);
  }

  @override
  Future<ToDo> getTodo(String id) async {
    return await _checkConnectivity()
      ? await _remote.getTodo(id)
      : await _local.getTodo(id);
  }

  @override
  Future<int> updateTodo(ToDo t) async {
    return await _checkConnectivity()
      ? await _remote.updateTodo(t)
      : await _local.updateTodo(t);
  }
  
}