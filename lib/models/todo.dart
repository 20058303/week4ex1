class ToDo {
  late int id;
  final String name;
  final String description;
  final bool complete;

  ToDo({required this.name, required this.description, this.complete=false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'complete': complete,
    };
  }

  @override
  String toString() => "$name: $description - $complete";
}