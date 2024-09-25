import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tasks_management/theme_manager/value_manager.dart';

class AuthDataProvider {
  final http.Client client;

  AuthDataProvider(this.client);

  Future<dynamic> register(Map<String, dynamic> postData) async {
    try {
      final response = await client.post(
          Uri.parse('${ValueManager.baseUrl}/api/developer/register'),
          body: jsonEncode(postData),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          });
      log(response.body.toString());

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as dynamic;
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<dynamic> login(Map<String, dynamic> postData) async {
    try {
      final response = await client.post(
          Uri.parse('${ValueManager.baseUrl}/api/developer/login'),
          body: jsonEncode(postData),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          });
      // log(response.body.toString());

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as dynamic;
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> getUser(String token) async {
    try {
      final response = await client
          .get(Uri.parse('${ValueManager.baseUrl}/api/developer'), headers: {
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

  Future<dynamic> logout(String token) async {
    try {
      final response = await client
          .post(Uri.parse('${ValueManager.baseUrl}/api/logout'), headers: {
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
