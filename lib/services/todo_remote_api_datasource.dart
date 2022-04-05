import 'dart:convert';

import 'package:week4ex1/models/todo.dart';
import 'package:week4ex1/services/todo_datasource.dart';
import 'package:http/http.dart' as http;

class ToDoRemoteAPIDatasource implements TodoDatasource {
  final String apiURL =
      "http://todoapi-env.eba-3my22sx6.ap-southeast-2.elasticbeanstalk.com/";

  @override
  Future<List<ToDo>> all() async {
    http.Response response = await http.get(Uri.parse(apiURL));
    if (response.statusCode != 200) {
      return <ToDo>[
        ToDo(name: "Unable to Connect!", description: "Please try again soon.")
      ];
    } else {
      List<dynamic> jsonList = jsonDecode(response.body);
      return List.generate(jsonList.length, (i) => ToDo.fromJson(jsonList[i]));
    }
  }

  @override
  Future<int> addTodo(ToDo t) async {
    http.Response response =
        await http.post(Uri.parse(apiURL), body: t.toMap());
    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    } else {
      return 1;
    }
  }

  @override
  Future<int> deleteTodo(ToDo t) async {
    http.Response response = await http.delete(Uri.parse(apiURL + t.id!));
    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    } else {
      return 1;
    }
  }

  @override
  Future<ToDo> getTodo(String id) async {
    http.Response response = await http.get(Uri.parse(apiURL + id));
    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    } else {
      return ToDo.fromJson(jsonDecode(response.body)) as Future<ToDo>;
    }
  }

  @override
  Future<int> updateTodo(ToDo t) async {
    http.Response response =
        await http.patch(Uri.parse(apiURL + t.id!), body: t.toMap());
    if (response.statusCode != 200) {
      throw Exception(response.statusCode.toString());
    } else {
      return 1;
    }
  }

  @override
  Future<int> deleteAll() async {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }
}
