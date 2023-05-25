import 'package:flutter/material.dart';
import 'package:task_app/task_bloc.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  final TaskBloc _taskBloc = TaskBloc();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _taskBloc.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tarefas'),
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
          const SizedBox(height: 20),

          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              labelText: 'Nova Tarefa',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 4.0,
              shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
              minimumSize: const Size(325.0, 50.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            onPressed: () {
              _taskBloc.addTask(_textEditingController.text);
              _textEditingController.clear();
            },
            child: const Text('Adicionar Tarefa'),
          ),
          Expanded(
            child: StreamBuilder<List<String>>(
              stream: _taskBloc.tasksStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final tasks = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tasks[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _taskBloc.removeTask(tasks[index]);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.all(5),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation(Colors.black),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          )
          // Lista de tarefas
        ]));
  }
}
