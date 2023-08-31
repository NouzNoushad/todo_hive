import 'package:hive/hive.dart';

import '../../model/todo_model.dart';
import '../../utils/constant.dart';

class TodoRepository {
  final Box<TodoModel> openBox = Hive.box<TodoModel>(dbName);

  List<TodoModel> getTodo() {
    return openBox.values.toList();
  }

  addTodo(TodoModel todoModel) {
    openBox.put(todoModel.id, todoModel);
  }

  deleteTodo(TodoModel todoModel) {
    openBox.delete(todoModel.id);
  }
}
