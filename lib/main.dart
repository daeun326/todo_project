import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<TodoItem> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _tasks[index].task,
                    style: _tasks[index].completed
                        ? TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)
                        : null,
                  ),
                  leading: Checkbox(
                    value: _tasks[index].completed,
                    onChanged: (bool? value) {
                      setState(() {
                        _tasks[index].completed = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTask = '';
              return AlertDialog(
                title: Text('Add a Task'),
                content: TextField(
                  onChanged: (value) {
                    newTask = value;
                  },
                  decoration: InputDecoration(hintText: 'Enter a task'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newTask.trim().isNotEmpty) {
                        setState(() {
                          _tasks.add(TodoItem(task: newTask.trim()));
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItem {
  String task;
  bool completed;

  TodoItem({required this.task, this.completed = false});
}
