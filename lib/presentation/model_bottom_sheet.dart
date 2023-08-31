import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_hive/data/bloc/todo_bloc/todo_bloc.dart';

import '../model/todo_model.dart';
import '../utils/constant.dart';
import '../widgets/custom_text_field.dart';

TextEditingController idController = TextEditingController();
TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();

addOrUpdateTodo(
    {required BuildContext context,
    TodoModel? todo,
    required TodoType todoType}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: idController,
                  hintText:
                      todoType == TodoType.update ? todo!.id.toString() : 'ID',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: titleController,
                  hintText: todoType == TodoType.update ? todo!.title : 'Title',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: contentController,
                  hintText:
                      todoType == TodoType.update ? todo!.content : 'Content',
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        String id = idController.text;
                        String title = titleController.text;
                        String content = contentController.text;
                        if (todoType == TodoType.update) {
                          id = id != '' ? id : todo!.id.toString();
                          title = title != '' ? title : todo!.title;
                          content = content != '' ? content : todo!.content;
                        }
                        if (id != '' && title != '' && content != '') {
                          print('Add or update');
                          TodoModel todoModel = TodoModel();
                          todoModel.id = int.parse(id);
                          todoModel.title = title;
                          todoModel.content = content;
                          if (todoType == TodoType.update) {
                            print(
                                '/////////////// Todo model updated : ${todoModel.id} ${todoModel.title} ${todoModel.content}');
                            context
                                .read<TodoBloc>()
                                .add(TodoUpdateEvent(todoModel));
                          } else {
                            context
                                .read<TodoBloc>()
                                .add(TodoAddEvent(todoModel));
                          }
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'All fields are required');
                        }
                        idController.text = '';
                        titleController.text = '';
                        contentController.text = '';
                      },
                      child: Text(
                        todoType == TodoType.update ? 'Update' : 'Save',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}
