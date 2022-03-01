import 'package:flutter/material.dart';
import 'package:week4ex1/models/todo.dart';

class ToDoWidget extends StatefulWidget {
  final ToDo todo;
  const ToDoWidget({ Key? key, required this.todo }) : super(key: key);

  @override
  _ToDoWidgetState createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: const BoxDecoration(
                // color: Colors.amberAccent[700],
                border: Border(left: BorderSide(color: Colors.white)),
              ),
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(5),
              child: Text(
                widget.todo.toString(),
                style: const TextStyle(
                  color: Colors.white,
                )
              ),
    );
  }
}