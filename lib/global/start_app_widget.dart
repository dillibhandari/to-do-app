import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/todo/presentation/bloc/todo_cubit.dart';
import 'package:todo_app/global/dependency_injection.dart' as di;

class StartAppWidget extends StatelessWidget {
  final Widget child;
  const StartAppWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>( create: (_) => di.sl<TodoCubit>()),
      ],
      child: child,
    );
  }
}
