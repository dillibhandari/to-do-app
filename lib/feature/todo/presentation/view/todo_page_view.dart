import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_utils.dart';
import 'package:todo_app/core/utils/dimens.dart';
import 'package:todo_app/feature/todo/presentation/bloc/todo_cubit.dart';
import 'package:todo_app/feature/todo/presentation/widget/todo_body_widget.dart';
import 'package:todo_app/feature/todo/presentation/widget/todo_form_widget.dart';

class TodoPageView extends StatefulWidget {
  const TodoPageView({super.key});

  @override
  State<TodoPageView> createState() => _TodoPageViewState();
}

class _TodoPageViewState extends State<TodoPageView> {
  @override
  void initState() {
    context.read<TodoCubit>().initialTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: actionButtons(),
      appBar: AppBar(),
      body: const TodoBodyView(),
    );
  }

  Widget actionButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          label: const Text("Add Todo"),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              scrollControlDisabledMaxHeightRatio: BorderSide.strokeAlignInside,
              useRootNavigator: true,
              backgroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      radiusX20 * Utils.getScalingFactor(context)),
                  topRight: Radius.circular(
                      radiusX20 * Utils.getScalingFactor(context)),
                ),
              ),
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                      height: sizeX250 * Utils.getScalingFactor(context),
                      child: const TodoFormWidget()),
                );
              },
            );
          },
        ),
        SizedBox(width: sizeX10 * Utils.getScalingFactor(context)),
        FloatingActionButton.extended(
          label: const Text("Delete Todo"),
          onPressed: () {
            context
                .read<TodoCubit>()
                .deleteTodo(context.read<TodoCubit>().checked);
          },
        ),
      ],
    );
  }
}
