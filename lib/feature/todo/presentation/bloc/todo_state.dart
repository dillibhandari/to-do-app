part of 'todo_cubit.dart';


sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}
final class TodoLoading extends TodoState{}
final class TodoSuccess extends TodoState{
  final List<Todos> listOfTodo;
  const TodoSuccess(this.listOfTodo);
   @override
  List<Object> get props => [listOfTodo];
}
