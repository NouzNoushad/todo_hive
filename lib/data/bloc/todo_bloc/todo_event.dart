part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoLoadedEvent extends TodoEvent {
  const TodoLoadedEvent();

  @override
  List<Object> get props => [];
}

class TodoAddEvent extends TodoEvent {
  final TodoModel todoModel;
  const TodoAddEvent(this.todoModel);

  @override
  List<Object> get props => [todoModel];
}

class TodoUpdateEvent extends TodoEvent {
  final TodoModel todoModel;
  const TodoUpdateEvent(this.todoModel);

  @override
  List<Object> get props => [todoModel];
}

class TodoDeleteEvent extends TodoEvent {
  final TodoModel todoModel;
  const TodoDeleteEvent(this.todoModel);

  @override
  List<Object> get props => [todoModel];
}
