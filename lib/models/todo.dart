import 'dart:convert';
import 'dart:math';

class ToDo {
  late String? id;
  final String name;
  final String description;
  bool? complete;

  ToDo({this.id, required this.name, required this.description, this.complete=false});

  Map<String, dynamic> toMap() {
    id ??= base64Encode(utf8.encode((name + description + String.fromCharCode(65 + Random().nextInt(48))))).split('=')[0];
    return {
      'id' : id,
      'name': name,
      'description': description,
      'complete': complete,
    };
  }

  ToDo.fromMap(Map<String, dynamic> res)
    : id = res['id'],
    name = res['name'],
    description = res['description'],
    complete = res['complete'];

  @override
  String toString() => "($id) $name: $description - $complete";
}