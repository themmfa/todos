import 'package:todos/data/model/todos_model.dart';

/// return completed todos
List<TodosModel> completedTodos(List<TodosModel> todos) {
  final completed = <TodosModel>[];
  for (var todo in todos) {
    if (todo.completed == true) {
      completed.add(todo);
    }
  }
  return completed;
}

/// return sorted todos by title
List<TodosModel> sortedByTitle(List<TodosModel> todos) {
  final sortedTodos = [...todos];
  sortedTodos.sort((a, b) => a.title!.compareTo(b.title!));
  return sortedTodos;
}
