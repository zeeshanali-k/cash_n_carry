
import 'package:bloc/bloc.dart';
import 'package:cash_n_carry/data/repository/auth_repository_impl.dart';
import 'package:cash_n_carry/domain/models/resource.dart';
import 'package:cash_n_carry/domain/models/user.dart';
import 'package:cash_n_carry/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(@Named.from(AuthRepositoryImpl) AuthRepository authRepository)
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoading());
      if (event is LoginEvent) {
        return handleLoginEvent(event, emit, authRepository);
      }
    });
  }

  Future<void> handleLoginEvent(LoginEvent event, Emitter<AuthState> emit,
      AuthRepository authRepository) {
    return emit.forEach(authRepository.loginUser(event.email, event.password),
        onData: (data) {
      if (data is ResourceSuccess) {
        return AuthResponse(user: data.data as User?);
      } else if (data is ResourceError) {
        return AuthResponse(error: data.message);
      } else {
        return AuthResponse(error: "asd");
      }
    });
  }
}
