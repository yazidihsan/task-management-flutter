import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_management/features/tasks/data/data_provider/tasks_data_provider.dart';
import 'package:tasks_management/features/tasks/models/tasks_model.dart';

class TasksRepository {
  final TasksDataProvider tasksDataProvider;

  TasksRepository(this.tasksDataProvider);

  Future<TasksModel> createTask(TasksModel task) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final rawData = await tasksDataProvider.createTask(
          task.toJson(), pref.getString("access_token").toString());

      return TasksModel.fromJson(rawData);
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<List<TasksModel>> getTasks() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final rawData = await tasksDataProvider
          .getTasks(pref.getString("access_token").toString());

      return rawData.map((json) => TasksModel.fromJson(json)).toList();
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<TasksModel> updateTask(int id, TasksModel task) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final rawData = await tasksDataProvider.updateTask(
          id, task.toJson(), pref.getString("access_token").toString());

      return TasksModel.fromJson(rawData);
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<String> deleteTask(int id) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final rawData = await tasksDataProvider.deleteTask(
          id, pref.getString("access_token").toString());

      return rawData['message'];
    } catch (e) {
      return throw Exception(e);
    }
  }
}
