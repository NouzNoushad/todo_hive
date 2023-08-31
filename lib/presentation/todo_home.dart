import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_hive/data/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_hive/presentation/model_bottom_sheet.dart';
import 'package:todo_hive/utils/colors.dart';
import 'package:todo_hive/utils/constant.dart';

class TodoHome extends StatelessWidget {
  const TodoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPicker.primaryColor,
        onPressed: () {
          addOrUpdateTodo(context: context, todoType: TodoType.add);
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorPicker.primaryColor,
            title: const Text('Todo'),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: BlocConsumer<TodoBloc, TodoState>(
              listener: (context, state) {
                if (state is TodoErrorState) {
                  Fluttertoast.showToast(msg: 'Unable to connect');
                }
                if (state is TodoAddedState) {
                  Fluttertoast.showToast(msg: 'Todo added');
                }
                if (state is TodoUpdatedState) {
                  Fluttertoast.showToast(msg: 'Todo updated');
                }
                if (state is TodoDeletedState) {
                  Fluttertoast.showToast(msg: 'Todo removed');
                }
              },
              builder: (context, state) {
                if (state is TodoLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorPicker.primaryColor,
                    ),
                  );
                }
                if (state is TodoLoadedState) {
                  if (state.todoModels.isEmpty) {
                    return const Center(
                      child: Text(
                        'What you like to do?',
                        style: TextStyle(
                          color: ColorPicker.hintColor,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        var todo = state.todoModels[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    todo.content,
                                    style: const TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                addOrUpdateTodo(
                                    context: context,
                                    todo: todo,
                                    todoType: TodoType.update);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<TodoBloc>()
                                    .add(TodoDeleteEvent(todo));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                            ),
                          ]),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: state.todoModels.length);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
