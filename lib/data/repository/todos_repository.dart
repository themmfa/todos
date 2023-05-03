import 'package:todos/data/api/todos_api.dart';

class TodosRepository {
  final _todosApi = TodosApi();

  Future<List<Map<String, dynamic>>> fetchTodos() async {
    return _todosApi.fetchTodos();
  }
}
