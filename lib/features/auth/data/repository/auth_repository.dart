import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_management/features/auth/data/data_provider/auth_data_provider.dart';
import 'package:tasks_management/features/auth/models/auth_model.dart';
import 'package:tasks_management/features/auth/models/user_model.dart';

class AuthRepository {
  final AuthDataProvider authDataProvider;

  AuthRepository(this.authDataProvider);

  Future<String> register(AuthModel user) async {
    try {
      final rawData = await authDataProvider.register(user.toJson());
      final pref = await SharedPreferences.getInstance();

      pref.setString("name", rawData["data"]["name"].toString());
      pref.setString("email", rawData["data"]["email"].toString());
      pref.setString("password", rawData["data"]["password"].toString());

      return rawData["message"].toString();
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<String> login(AuthModel user) async {
    try {
      final rawData = await authDataProvider.login(user.toJson());
      final pref = await SharedPreferences.getInstance();

      log('token: ${rawData["token"]}');

      pref.setString('access_token', rawData["token"].toString());

      log('token pref: ${pref.getString('access_token')}');

      return rawData["message"].toString();
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<UserModel> user() async {
    try {
      final pref = await SharedPreferences.getInstance();

      final rawData = await authDataProvider
          .getUser(pref.getString('access_token').toString());

      return UserModel.fromJson(rawData);
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<String> logout() async {
    try {
      final pref = await SharedPreferences.getInstance();

      final rawData = await authDataProvider
          .logout(pref.getString('access_token').toString());

      pref.remove('access_token');
      pref.remove('email');
      pref.remove('name');
      pref.remove('password');

      return rawData["message"].toString();
    } catch (e) {
      return throw Exception(e);
    }
  }
}
