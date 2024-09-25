import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tasks_management/theme_manager/value_manager.dart';

class TasksDataProvider {
  final http.Client client;

  TasksDataProvider(this.client);

  Future<Map<String, dynamic>> createTask(
      Map<String, dynamic> postData, String token) async {
    try {
      final response = await client.post(
          Uri.parse('${ValueManager.baseUrl}/api/tasks'),
          body: jsonEncode(postData),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      log(response.body.toString());

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<List<dynamic>> getTasks(String token) async {
    try {
      final response = await client
          .get(Uri.parse('${ValueManager.baseUrl}/api/tasks'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      log(response.body.toString());

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> updateTask(
      int id, Map<String, dynamic> postData, String token) async {
    try {
      final response = await client.put(
          Uri.parse('${ValueManager.baseUrl}/api/tasks/$id'),
          body: jsonEncode(postData),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      log(response.body.toString());

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<dynamic> deleteTask(int id, String token) async {
    try {
      final response = await client
          .delete(Uri.parse('${ValueManager.baseUrl}/api/tasks/$id'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      log(response.body.toString());

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as dynamic;
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      return throw Exception(error);
    }
  }
}
