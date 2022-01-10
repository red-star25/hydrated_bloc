class Todo {
  final String todoTitle;
  final String todoId;
  bool isCompleted;

  Todo(this.todoTitle, this.todoId, this.isCompleted);

  Todo.fromJson(Map<String, dynamic> json)
      : todoTitle = json['todoTitle'],
        todoId = json['todoId'],
        isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
        'todoTitle': todoTitle,
        'todoId': todoId,
        'isCompleted': isCompleted,
      };
}
