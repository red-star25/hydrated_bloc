import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc_project/bloc/todo_bloc.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final _todoTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _todoTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: SizedBox(
                      height: 200,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Add Todo"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _todoTitleController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text(
                                  "Enter Todo Name",
                                ),
                              ),
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Field can't be empty"
                                    : null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<TodoBloc>().add(
                                        AddTodo(_todoTitleController.text));
                                    _todoTitleController.clear();

                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text("Add"))
                          ],
                        ),
                      ),
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TodoList(),
        ),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoaded) {
          if (state.listOfTodo.isEmpty) {
            return const Center(
              child: Text("Add new Todo"),
            );
          }
          return ListView.builder(
            itemCount: state.listOfTodo.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  key: Key(state.listOfTodo[index].todoId),
                  onDismissed: (direction) {
                    context
                        .read<TodoBloc>()
                        .add(RemoveTodo(state.listOfTodo[index].todoId));
                  },
                  child: CheckboxListTile(
                      tileColor: Colors.blueAccent.shade100,
                      title: Text(
                        state.listOfTodo[index].todoTitle,
                        style: state.listOfTodo[index].isCompleted
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough)
                            : null,
                      ),
                      value: state.listOfTodo[index].isCompleted,
                      onChanged: (value) async {
                        context.read<TodoBloc>().add(
                              UpdateTodoState(
                                  value!, state.listOfTodo[index].todoId),
                            );
                      }),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
