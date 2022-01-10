import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hydrated_bloc_project/data/model/todo.dart';
import 'package:hydrated_bloc_project/data/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
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

  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    try {
      final listOfTodo = (json['todo'] as List)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList();

      todoRepository.todoList = listOfTodo;
      return TodoLoaded(listOfTodo);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    if (state is TodoLoaded) {
      return state.toJson();
    } else {
      return null;
    }
  }
}
