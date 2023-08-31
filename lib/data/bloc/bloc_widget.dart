import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_hive/data/bloc/todo_bloc/todo_bloc.dart';
import '../repositories/todo_repository.dart';

class BlocWidget extends StatelessWidget {
  final Widget child;
  const BlocWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider(
        create: (context) => TodoBloc(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        )..add(const TodoLoadedEvent()),
        child: child,
      ),
    );
  }
}
