part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<TodoModel> todoModels;
  const TodoLoadedState(this.todoModels);

  @override
  List<Object> get props => [todoModels];
}

class TodoAddedState extends TodoState {
  const TodoAddedState();

  @override
  List<Object> get props => [];
}

class TodoUpdatedState extends TodoState {
  const TodoUpdatedState();

  @override
  List<Object> get props => [];
}

class TodoDeletedState extends TodoState {
  const TodoDeletedState();

  @override
  List<Object> get props => [];
}

class TodoErrorState extends TodoState {
  final String error;
  const TodoErrorState(this.error);

  @override
  List<Object> get props => [error];
}
