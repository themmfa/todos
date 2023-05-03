import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todos/data/constants/api_constants.dart';

/// Todos request class
class TodosApi {
  /// Function to fetch todos from api endpoint
  Future<List<Map<String, dynamic>>> fetchTodos() async {
    final response = await http.get(Uri.parse(ApiConstants.url));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> dataList = (json.decode(response.body) as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();

      return dataList;
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
