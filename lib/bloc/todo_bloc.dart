import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodos>(_onAddTodos);
    on<DeleteTodos>(_onDeleteTodos);
    on<UpdateTodos>(_onupdateTodos);
  }

  FutureOr<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) {
    emit(TodoLoaded(todos: event.todos));
  }

  FutureOr<void> _onAddTodos(AddTodos event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todos: List.from(state.todos)..add(event.todos)));
    }
  }

  FutureOr<void> _onDeleteTodos(DeleteTodos event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = state.todos.where((element) {
        return element.id != event.todos.id;
      }).toList();
      emit(TodoLoaded(todos: todos));
    }
  }

  FutureOr<void> _onupdateTodos(UpdateTodos event, Emitter<TodoState> emit) {}
}
