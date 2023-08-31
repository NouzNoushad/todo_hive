import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_hive/data/repositories/todo_repository.dart';
import 'package:todo_hive/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<TodoLoadedEvent>(getTodo);
    on<TodoAddEvent>(addTodo);
    on<TodoDeleteEvent>(deleteTodo);
    on<TodoUpdateEvent>(updateTodo);
  }

  FutureOr<void> getTodo(TodoLoadedEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    try {
      List<TodoModel> todoModels = todoRepository.getTodo();
      emit(TodoLoadedState(todoModels));
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }

  FutureOr<void> addTodo(TodoAddEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    try {
      todoRepository.addTodo(event.todoModel);
      add(const TodoLoadedEvent());
      emit(const TodoAddedState());
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }

  FutureOr<void> deleteTodo(TodoDeleteEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    try {
      todoRepository.deleteTodo(event.todoModel);
      add(const TodoLoadedEvent());
      emit(const TodoDeletedState());
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }

  FutureOr<void> updateTodo(TodoUpdateEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    try {
      todoRepository.addTodo(event.todoModel);
      add(const TodoLoadedEvent());
      emit(const TodoUpdatedState());
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }
}
