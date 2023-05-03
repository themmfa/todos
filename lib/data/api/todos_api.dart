import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todos/data/constants/api_constants.dart';

/// Todos request class
class TodosApi {
  /// Function to fetch todos from api endpoint
  Future<List<Map<String, dynamic>>> fetchTodos() async {
    final response = await http.get(Uri.parse(ApiConstants.url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
