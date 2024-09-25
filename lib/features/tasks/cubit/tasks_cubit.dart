import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks_management/features/tasks/data/repository/tasks_repository.dart';
import 'package:tasks_management/features/tasks/models/tasks_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TasksRepository tasksRepository;
  TasksCubit(this.tasksRepository) : super(TasksInitial());

  void createTask(TasksModel task) async {
    try {
      emit(TasksLoading());

      final result = await tasksRepository.createTask(task);
      emit(TasksCreated(task: result));
    } catch (e) {
      emit(TasksFailed(message: e.toString()));
    }
  }

  void getTasks() async {
    try {
      emit(TasksLoading());

      final result = await tasksRepository.getTasks();
      emit(TasksSuccess(tasks: result));
    } catch (e) {
      emit(TasksFailed(message: e.toString()));
    }
  }

  void updateTask(int id, TasksModel task) async {
    try {
      emit(TasksLoading());

      final result = await tasksRepository.updateTask(id, task);
      emit(TasksUpdated(task: result));
    } catch (e) {
      emit(TasksFailed(message: e.toString()));
    }
  }

  void deleteTask(int id) async {
    try {
      emit(TasksLoading());

      final result = await tasksRepository.deleteTask(id);
      emit(TasksDeleted(message: result));
    } catch (e) {
      emit(TasksFailed(message: e.toString()));
    }
  }
}
