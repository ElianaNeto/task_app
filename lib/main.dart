import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_app/tasklist.dart';
import 'task_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp(
        title: 'Lista de Tarefas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TaskListWidget(),
      ),
    );
  }

  @override
  void dispose() {
    _taskBloc.dispose();
    dispose();
  }
}
