// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class Todo {
  final String title;
  final String status;
  final String id;
  bool isProcessing;

  Todo(
      {required this.id,
      required this.title,
      required this.status,
      required this.isProcessing});
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class _MyAppState extends State<MyApp> {
  int count = 0;
  final BASE = "insert your backend url here";
  final _formKey = GlobalKey<FormState>();
  final newTaskController = TextEditingController();
  final paperColor = const Color(0xff111111);
  final awesomeGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xff57048A),
        Color(0xff4528DC),
      ]);

  List<Todo> _todos = [];

  void getTodos() async {
    final resp = await http.get(Uri.parse(BASE + "/route"));
    var jsonData = json.decode(resp.body);

    List<Todo> todos = [];
    for (var todo in jsonData) {
      Todo t = Todo(
        id: todo["_id"],
        title: todo["content"],
        status: todo["status"],
        isProcessing: false,
      );
      if (t.status == "pending") {
        todos.add(t);
      }
    }
    setState(() {
      _todos = todos;
    });
  }

  void handleTodo(Todo currentTodo, String operation) async {
    setState(() {
      currentTodo.isProcessing = true;
    });

    var url;
    if (operation == "mark as done") {
      url = BASE + '/route';
    } else if (operation == "delete") {
      url = BASE + '/route';
    }
    final resp = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': currentTodo.id,
      }),
    );

    final updatedTodos = json.decode(resp.body);
    // print(updatedTodos.toString());
    List<Todo> todos = [];
    for (var todo in updatedTodos) {
      Todo t = Todo(
        id: todo["_id"],
        title: todo["content"],
        status: todo["status"],
        isProcessing: false,
      );
      if (t.status == "pending") todos.add(t);
    }
    setState(() {
      _todos = todos;
    });
  }

  void addNewTask(String newTask) async {
    final resp = await http.post(
      Uri.parse(BASE + '/route'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'content': newTask,
        'status': 'pending',
      }),
    );
    final updatedTodos = json.decode(resp.body);
    // print(updatedTodos.toString());
    List<Todo> todos = [];
    for (var todo in updatedTodos) {
      Todo t = Todo(
        id: todo["_id"],
        title: todo["content"],
        status: todo["status"],
        isProcessing: false,
      );
      if (t.status == "pending") todos.add(t);
    }
    setState(() {
      _todos = todos;
    });
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: Scaffold(
          backgroundColor: const Color(0xff09080d),
          appBar: AppBar(
            foregroundColor: Colors.white,
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: awesomeGradient),
            ),
            title: Text(
              'Pending Tasks',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: paperColor,
          ),
          drawer: Drawer(
              backgroundColor: paperColor,
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          TextFormField(
                            // The validator receives the text that the user has entered.
                            decoration:
                                const InputDecoration(labelText: 'New Task'),
                            controller: newTaskController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                addNewTask(newTaskController.text);
                              }
                            },
                            child: Text('Add task'),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff57048A)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 16.0)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 24))),
                          )
                        ],
                      )))),
          body: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: _todos.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: _todos.reversed
                        .toList()
                        .map((todo) => Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5.0),
                              child: Card(
                                  color: paperColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: ListTile(
                                      leading: todo.isProcessing
                                          ? SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                              ),
                                            )
                                          : null,
                                      title: Text(todo.title),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                handleTodo(
                                                    todo, 'mark as done');
                                              },
                                              icon: Icon(
                                                Icons.check,
                                                color: const Color(0xff4528DC),
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                handleTodo(todo, 'delete');
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.grey[900],
                                              )),
                                        ],
                                      ),
                                    ),
                                  )),
                            ))
                        .toList()),
          ),
        ));
  }
}
