import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/enum.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  List<Todos> listOfTodo = [];
  List<Todos> checked = [];

  initialTodos() {
    emit(TodoLoading());
    listOfTodo = [
      Todos(
        status: TodoStatus.inProgress,
        date: DateTime.now(),
        value: "First todo",
      ),
      Todos(
        status: TodoStatus.completed,
        date: DateTime.now(),
        value: "Second todo",
      ),
      Todos(
        status: TodoStatus.completed,
        date: DateTime.now(),
        value: "Third todo",
      )
    ];
    emit(TodoSuccess(listOfTodo));
  }

  deleteTodo(List<Todos> todos) {
    emit(TodoLoading());
    listOfTodo.removeWhere((todo) => todos.contains(todo));
    emit(TodoSuccess(listOfTodo));
  }

  addTodos(String title, bool checkValue) {
    emit(TodoLoading());
    DateTime time = DateTime.now();
    TodoStatus status = TodoStatus.inProgress;
    listOfTodo.add(Todos(status: status, date: time, value: title));
    emit(TodoSuccess(listOfTodo));
  }
}

class Todos extends Equatable {
  final String value;
  final DateTime date;
  final TodoStatus status;
  const Todos({required this.status, required this.date, required this.value});

  @override
  List<Object?> get props => [value];
}
