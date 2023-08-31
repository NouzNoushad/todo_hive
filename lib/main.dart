import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/presentation/todo_home.dart';
import 'package:todo_hive/utils/colors.dart';
import 'package:todo_hive/utils/constant.dart';

import 'data/bloc/bloc_widget.dart';
import 'model/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(dbName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocWidget(
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorPicker.seedColor),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  final GoRouter router = GoRouter(initialLocation: '/', routes: [
    GoRoute(path: '/', builder: (context, state) => const TodoHome())
  ]);
}
