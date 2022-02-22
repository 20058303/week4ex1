import 'package:flutter/material.dart';

import 'models/todomodel.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ToDo App',
      home: ToDoHomePage(title: 'ToDo App Title'),
    );
  }
}

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({ Key? key, required this.title }) : super(key: key);
  final String title;

  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {

  final TextEditingController _controlName = TextEditingController();
  final TextEditingController _controlDescription = TextEditingController();

  final List<ToDo> todos = <ToDo>[
    ToDo(name: "Shopping", description: "Pick up Groceries"),
    ToDo(name: "Paint", description: "Paint the kitchen")
  ];

  void _openAddTodo() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Todo"),
          content: Column(children: <Widget> [
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
              child: Text("Title")
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
              child: TextFormField(
                controller: _controlName,
              )
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 8),
              child: Text("Description")
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
              child: TextFormField(
                controller: _controlDescription,
              )
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todos.add(ToDo(
                    name: _controlName.text,
                    description: _controlDescription.text)
                  );
                });
                Navigator.pop(context);
              },
              child: const Text("Add"))
          ],
          mainAxisSize: MainAxisSize.min,
          )
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder:(BuildContext context, int i) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.amberAccent[700],
                border: const Border(left: BorderSide(color: Colors.white)),
              ),
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(5),
              child: Text(
                todos[i].toString(),
                style: const TextStyle(
                  color: Colors.white,
                )
                ),
            );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        tooltip: "Add new ToDo",
        child: const Icon(Icons.add),
      ),
    );
  }
}