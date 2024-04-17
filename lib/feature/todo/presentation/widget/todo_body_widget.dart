import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_utils.dart';
import 'package:todo_app/core/utils/enum.dart';
import 'package:todo_app/feature/todo/presentation/bloc/todo_cubit.dart';

class TodoBodyView extends StatefulWidget {
  const TodoBodyView({super.key});

  @override
  State<TodoBodyView> createState() => _TodoBodyViewState();
}

class _TodoBodyViewState extends State<TodoBodyView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        if (state is TodoSuccess) {
          return Padding(
              padding: EdgeInsets.all(18.0 * Utils.getScalingFactor(context)),
              child: SizedBox(
                height: 600 * Utils.getScalingFactor(context),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.listOfTodo.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Draggable<Todos>(
                            data: state.listOfTodo[index],
                            feedback: buildTodoItem(state.listOfTodo[index],
                                isDragging: true),
                            child: buildTodoItem(state.listOfTodo[index],
                                isDragging: true),
                            childWhenDragging:
                                _whileDragging(state.listOfTodo[index]),
                            onDragEnd: (drag) {
                              RenderBox renderBox =
                                  context.findRenderObject() as RenderBox;
                              onDragEnd(renderBox.globalToLocal(drag.offset));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  buildTodoItem(Todos todo, {required bool isDragging}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: isDragging ? Colors.transparent : Colors.white,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: context.read<TodoCubit>().checked.contains(todo),
            onChanged: (value) {
              if (context.read<TodoCubit>().checked.contains(todo)) {
                context.read<TodoCubit>().checked.remove(todo);
              } else {
                context.read<TodoCubit>().checked.add(todo);
              }
              setState(() {});
            },
          ),
          Expanded(
            child: Text(todo.value),
          ),
          Text(
            Utils().timeAgo(todo.date),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 20),
          Text(todo.status == TodoStatus.completed
              ? "completed"
              : todo.status == TodoStatus.inProgress
                  ? "progress"
                  : "Ongoing")
        ],
      ),
    );
  }

  _whileDragging(Todos todo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: AppColors.black50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(todo.value),
          ),
          Text(
            Utils().timeAgo(todo.date),
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void onDragEnd(Offset globalToLocal) {
    setState(() {});
  }
}
