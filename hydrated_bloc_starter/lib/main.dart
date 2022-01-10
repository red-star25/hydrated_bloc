import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc_project/bloc/todo_bloc.dart';
import 'package:hydrated_bloc_project/data/repository/todo_repository.dart';

import 'presentation/todo_home.dart';

void main() async {
  runApp(RepositoryProvider(
    create: (context) => TodoRepository(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(
        RepositoryProvider.of<TodoRepository>(context),
      ),
      child: const MaterialApp(
        home: TodoHome(),
      ),
    );
  }
}
