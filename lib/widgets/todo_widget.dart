import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week4ex1/models/todo.dart';
import 'package:week4ex1/models/todo_list.dart';

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
              height: 60,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
              child: Row(
                children: [
                  Checkbox(
                    value: widget.todo.complete,
                    onChanged: (bool? newValue) {
                      setState(() {
                        widget.todo.complete = newValue;
                        Provider.of<ToDoList>(context, listen: false).updateToDo(widget.todo);
                      });
                    }
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 12, 0),
                    child: VerticalDivider(
                      width: 2,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todo.name.toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )
                      ),
                      Text(
                        widget.todo.description.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                        )
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}