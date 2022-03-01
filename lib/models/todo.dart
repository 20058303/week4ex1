class ToDo {
  final String name;
  final String description;
  final bool complete;

  ToDo({required this.name, required this.description, this.complete=false});

  @override
  String toString() => "$name: $description - $complete";
}