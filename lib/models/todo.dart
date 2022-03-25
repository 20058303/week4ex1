class ToDo {
  final int? id;
  final String name;
  final String description;
  bool? complete;

  ToDo({this.id, required this.name, required this.description, this.complete=false});

  Map<String, dynamic> toMap() {
    return {
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
  String toString() => "$name: $description - $complete";
}