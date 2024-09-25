import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks_management/features/auth/data/repository/auth_repository.dart';
import 'package:tasks_management/features/auth/models/auth_model.dart';
import 'package:tasks_management/features/auth/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void register(AuthModel user) async {
    try {
      emit(AuthLoading());

      final result = await authRepository.register(user);

      emit(AuthSuccess(message: result));
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  void login(AuthModel user) async {
    try {
      emit(AuthLoading());

      final result = await authRepository.login(user);

      emit(AuthSuccess(message: result));
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  void user() async {
    try {
      emit(AuthLoading());

      final result = await authRepository.user();

      emit(AuthProfileLoaded(user: result));
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  void logout() async {
    try {
      emit(AuthLoading());

      final result = await authRepository.logout();

      emit(AuthSuccess(message: result));
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }
}
