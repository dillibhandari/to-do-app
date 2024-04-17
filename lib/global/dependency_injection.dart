import 'package:get_it/get_it.dart';
import 'package:todo_app/feature/todo/presentation/bloc/todo_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> initialize() async {
  sl.registerFactory(() => TodoCubit());
}
