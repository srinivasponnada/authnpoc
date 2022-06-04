// dart async library we will refer to when setting up real time updates
import 'dart:async';
// flutter and ui libraries
import 'package:flutter/material.dart';
// amplify packages we will need to use
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
// amplify configuration and models that should have been generated for you
import 'models/ModelProvider.dart';
import 'models/Job.dart';
import 'amplifyconfiguration.dart';

class MyJobsApp extends StatefulWidget {
  const MyJobsApp({Key? key}) : super(key: key);
  @override
  _MyJobsAppState createState() => _MyJobsAppState();
}

class _MyJobsAppState extends State<MyJobsApp> {

  List<Job> _todos = [];

  @override
  void initState() {
    // to be filled in a later step

    // kick off app initialization
    _initializeApp();

    super.initState();
  }

  @override
  void dispose() {
    // to be filled in a later step
    super.dispose();
  }

  Future<void> _initializeApp() async {
    try {
      List<Job> _todos = await Amplify.DataStore.query(Job.classType);
    } on DataStoreException catch (e) {
      print('Query failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Jobs List'),
      ),
      //body: Center(child: CircularProgressIndicator()),
      body: TodosList(todos: _todos),
    );
  }
}

class TodosList extends StatelessWidget {
  final List<Job> todos;

  TodosList({required this.todos});

  @override
  Widget build(BuildContext context) {
    return todos.length >= 1
        ? ListView(
        padding: EdgeInsets.all(8),
        children: todos.map((todo) => TodoItem(todo: todo)).toList())
        : Center(child: Text('Tap button below to add a todo!'));
  }
}

class TodoItem extends StatelessWidget {
  final double iconSize = 24.0;
  final Job todo;

  TodoItem({required this.todo});

  void _deleteTodo(BuildContext context) async {
    // to be filled in a later step
  }

  Future<void> _toggleIsComplete() async {
    // to be filled in a later step
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _toggleIsComplete();
        },
        onLongPress: () {
          _deleteTodo(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.jobSummary,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text( (todo.appointmentStartLocalTime).toString() ),
                ],
              ),
            ),
            /*Icon(
                todo.isComplete
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                size: iconSize),*/
          ]),
        ),
      ),
    );
  }
}