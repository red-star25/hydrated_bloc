part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> listOfTodo;

  const TodoLoaded(this.listOfTodo);

  @override
  List<Object> get props => [listOfTodo];
}
