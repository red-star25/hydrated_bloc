import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc_project/data/model/todo.dart';
import 'package:hydrated_bloc_project/data/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoLoaded(todoRepository.todoList)) {
    on<AddTodo>((event, emit) async {
      emit(TodoLoading());
      final updatedTodoList = todoRepository.addTodo(event.todoTitle);
      emit(TodoLoaded(updatedTodoList));
    });
    on<RemoveTodo>((event, emit) {
      emit(TodoLoading());
      final updatedTodoList = todoRepository.removeTodo(event.id);
      emit(TodoLoaded(updatedTodoList));
    });

    on<UpdateTodoState>((event, emit) async {
      emit(TodoLoading());
      final updatedTodoList =
          todoRepository.updateTodoState(event.isCompleted, event.id);
      emit(TodoLoaded(updatedTodoList));
    });
  }
}
