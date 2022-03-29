class ToDo {
  late int? id;
  final String name;
  final String description;
  bool? complete;

  ToDo(
      {this.id,
      required this.name,
      required this.description,
      this.complete = false});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'complete': complete == false ? 0 : 1,
    };
  }

  ToDo.fromMap(Map<String, dynamic> res)
      : id = res['rowid'],
        name = res['name'],
        description = res['description'],
        complete = res['complete'] ?? 'false';

  @override
  String toString() => "($id) $name: $description - $complete";
}
