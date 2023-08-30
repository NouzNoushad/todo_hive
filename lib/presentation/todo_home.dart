import 'package:flutter/material.dart';
import 'package:todo_hive/utils/colors.dart';

class TodoHome extends StatelessWidget {
  const TodoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPicker.primaryColor,
        title: const Text('Todo'),
        centerTitle: true,
      ),
    );
  }
}
