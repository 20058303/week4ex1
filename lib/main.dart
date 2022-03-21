import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'services/sqlite_datasource.dart';
import 'services/todo_datasource.dart';
import 'package:provider/provider.dart';
import 'package:week4ex1/widgets/todo_widget.dart';
import 'models/todo.dart';
import 'models/todo_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerLazySingleton<TodoDatasource>(() => LocalSQLiteDatasource());
  runApp(ChangeNotifierProvider(
    create: (context) => ToDoList(),
    child: const ToDoApp(),
  ));
  //runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'ToDo App',
      home: const ToDoHomePage(title: 'ToDo App Title'),
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
                Provider.of<ToDoList>(context, listen: false).addToDo(
                  ToDo(
                    name: _controlName.text,
                    description: _controlDescription.text
                  )
                );
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
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
              child: Consumer<ToDoList>(builder: (context, model, child) {
                return Text("Uncomplete: " + model.todoCount.toString());
              },
          ),)
          ),
        ],
      ),
      body: Center(
        child: Consumer<ToDoList>(
          builder:(context, model, child) {
            return RefreshIndicator(
              onRefresh: model.refresh,
              child: ListView.builder(
                itemCount: model.todos.length,
                itemBuilder:(BuildContext context, int i) {
                  return ToDoWidget(todo: model.todos[i]);
                }
              ),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        tooltip: "Add new ToDo",
        child: const Icon(Icons.add),
      ),
    );
  }
}