part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {
  final List<Todo> todos;

  const LoadTodos({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

class AddTodos extends TodoEvent {
  final Todo todos;

  const AddTodos({required this.todos});

  @override
  List<Object> get props => [todos];
}

class UpdateTodos extends TodoEvent {
  final Todo todos;

  const UpdateTodos({required this.todos});

  @override
  List<Object> get props => [todos];
}

class DeleteTodos extends TodoEvent {
  final Todo todos;

  const DeleteTodos({required this.todos});

  @override
  List<Object> get props => [todos];
}
