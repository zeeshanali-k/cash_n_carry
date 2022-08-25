import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cash_n_carry/data/repository/auth_repository_impl.dart';
import 'package:cash_n_carry/domain/models/resource.dart';
import 'package:cash_n_carry/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(@Named.from(AuthRepositoryImpl) AuthRepository authRepository)
      : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
      if (event is RegisterUserEvent) {
        log("bloc");
        emit(Registering());
        return handleRegisterEvent(event, emit, authRepository);
      }
    });
  }

  Future<void> handleRegisterEvent(RegisterUserEvent event,
      Emitter<RegisterState> emit, AuthRepository authRepository) {
    return emit.forEach(
        authRepository.registerUser(event.name, event.email, event.password),
        onData: (data) {
      if (data is ResourceSuccess) {
        return const RegisterResponse(success: true);
      } else {
        return RegisterResponse(
            success: false, error: (data as ResourceError).message);
      }
    });
  }
}
