import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/feature/todo/presentation/view/todo_page_view.dart';
import 'package:todo_app/global/start_app_widget.dart';
import 'package:todo_app/global/dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initialize();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StartAppWidget(
      child: MaterialApp(
        title: 'To Do App ',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: false),
        home: const TodoPageView(),
      ),
    );
  }
}

// class TaskManager extends StatefulWidget {
//   @override
//   _TaskManagerState createState() => _TaskManagerState();
// }

// class _TaskManagerState extends State<TaskManager> {
//   List<Task> tasks = [
//     Task(title: 'Task 1', dueDate: DateTime.now().add(Duration(days: 1))),
//     Task(title: 'Task 2', dueDate: DateTime.now().add(Duration(days: 2))),
//     Task(title: 'Task 3', dueDate: DateTime.now().add(Duration(days: 3))),
//   ];

//   Map<TaskStatus, List<Task>> tasksByStatus = {
//     TaskStatus.InProgress: [],
//     TaskStatus.Completed: [],
//     TaskStatus.Uncompleted: [],
//   };

//   @override
//   void initState() {
//     super.initState();
//     _refreshTaskLists();
//   }

//   void _refreshTaskLists() {
//     tasksByStatus[TaskStatus.InProgress] = tasks.where((task) => task.status == TaskStatus.InProgress).toList();
//     tasksByStatus[TaskStatus.Completed] = tasks.where((task) => task.status == TaskStatus.Completed).toList();
//     tasksByStatus[TaskStatus.Uncompleted] = tasks.where((task) => task.status == TaskStatus.Uncompleted).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Manager'),
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _buildTaskList(TaskStatus.InProgress),
//           _buildTaskList(TaskStatus.Completed),
//           _buildTaskList(TaskStatus.Uncompleted),
//         ],
//       ),
//     );
//   }

//   Widget _buildTaskList(TaskStatus status) {
//     return Expanded(
//       child: DragTarget<Task>(
//         builder: (BuildContext context, List<Task?> candidateData, List<dynamic> rejectedData) {
//           return Column(
//             children: <Widget>[
//               Text(_statusText(status)),
//               SizedBox(height: 8),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: tasksByStatus[status]!.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Draggable<Task>(
//                       data: tasksByStatus[status]![index],
//                       feedback: _buildTaskItem(tasksByStatus[status]![index], isDragging: true),
//                       child: _buildTaskItem(tasksByStatus[status]![index]),
//                       childWhenDragging: Container(),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//         onAccept: (Task? data) {
//           if (data != null) {
//             setState(() {
//               data.status = status;
//               _refreshTaskLists();
//             });
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildTaskItem(Task task, {bool isDragging = false}) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       margin: EdgeInsets.symmetric(vertical: 4),
//       color: isDragging ? Colors.transparent : Colors.white,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Text(task.title),
//           ),
//           Text(
//             '${task.dueDate.year}-${task.dueDate.month}-${task.dueDate.day}',
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }

//   String _statusText(TaskStatus status) {
//     switch (status) {
//       case TaskStatus.InProgress:
//         return 'In Progress';
//       case TaskStatus.Completed:
//         return 'Completed';
//       case TaskStatus.Uncompleted:
//         return 'Uncompleted';
//     }
//   }
// }
