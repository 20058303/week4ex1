import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  bool? complete;

  ToDo(
      {this.id = '',
      required this.name,
      required this.description,
      this.complete = false});

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        complete: json['complete'] ?? 'false');
  }

  Map<String, dynamic> toMap() {
    //id ??= base64Encode(utf8.encode((name + description + String.fromCharCode(65 + Random().nextInt(48))))).split('=')[0];
    return {
      '_id': id,
      'name': name,
      'description': description,
      'complete': complete,
    };
  }

  ToDo.fromMap(Map<String, dynamic> res)
      : id = res['_id'],
        name = res['name'],
        description = res['description'],
        complete = res['complete'] ?? false;

  @override
  String toString() => "($id) $name: $description - $complete";
}

class ToDoAdapter extends TypeAdapter<ToDo> {
  @override
  ToDo read(BinaryReader reader) {
    return ToDo(
        id: reader.read(0),
        name: reader.read(1),
        description: reader.read(2),
        complete: reader.read(3));
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.complete);
  }
}
