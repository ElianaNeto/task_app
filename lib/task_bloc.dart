import 'dart:async';

class TaskBloc {
  final _taskController = StreamController<List<String>>();
  Stream<List<String>> get tasksStream => _taskController.stream;
  final List<String> _tasks = []; 

  void dispose() {
    _taskController.close();
  }

   void addTask(String task) {

    _tasks.add(task);
    _taskController.sink.add(_tasks);
  }

  void removeTask(String task) {
    
    _tasks.remove(task);
    _taskController.sink.add(_tasks);
  }
}
