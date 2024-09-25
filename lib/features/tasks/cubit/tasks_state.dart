part of 'tasks_cubit.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksSuccess extends TasksState {
  final List<TasksModel> tasks;

  const TasksSuccess({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

final class TasksCreated extends TasksState {
  final TasksModel task;

  const TasksCreated({required this.task});

  @override
  List<Object> get props => [task];
}

final class TasksUpdated extends TasksState {
  final TasksModel task;

  const TasksUpdated({required this.task});

  @override
  List<Object> get props => [task];
}

final class TasksDeleted extends TasksState {
  final String message;

  const TasksDeleted({required this.message});

  @override
  List<Object> get props => [message];
}

final class TasksFailed extends TasksState {
  final String message;

  const TasksFailed({required this.message});

  @override
  List<Object> get props => [message];
}
