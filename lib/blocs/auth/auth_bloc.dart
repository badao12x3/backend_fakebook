import 'package:bloc/bloc.dart';
import 'package:fakebook_frontend/blocs/auth/auth_event.dart';
import 'package:fakebook_frontend/blocs/auth/auth_state.dart';
import 'package:fakebook_frontend/models/auth_user_model.dart';
import 'package:fakebook_frontend/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository authRepository;

  AuthBloc(): super(AuthState.initial()) {
    authRepository = AuthRepository();

    on<Login>(_onLogin);
    on<Logout>(_onLogout);
  }

  void _onLogin(Login event, Emitter<AuthState> emit) async {
    final phone = event.phone;
    final password = event.password;
    try {
      final authUser = await authRepository.login(phone: phone, password: password);
      if(authUser.code == '1000' && authUser.message == 'OK') {
        emit(AuthState(status: AuthStatus.authenticated, authUser: authUser));
      }
      if(authUser.code == '9995') {
        emit(AuthState(status: AuthStatus.unauthenticated, authUser: authUser));
      }
    } catch(_) {
      emit(state.copyWith(status: AuthStatus.unknown, authUser: AuthUser.initial()));
    }
  }

  void _onLogout(Logout event, Emitter<AuthState> emit) {
    // final prefs = await SharedPreferences.getInstance();
    // final successRemoveUserData = await prefs.remove('user');
    // print(successRemoveUserData);
    emit(state.copyWith(status: AuthStatus.unauthenticated, authUser: AuthUser.initial()));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('#AUTH OBSERVER: $error');
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    // print('#AUTH OBSERVER: $transition');
  }

  @override
  void onEvent(AuthEvent event) {
    super.onEvent(event);
    print('#AUTH OBSERVER: $event');
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print('#AUTH OBSERVER: { stateCurrent:  statusCurrent: ${change.currentState.status}, authUserCurrent: ${change.currentState.authUser} }');
    print('#AUTH OBSERVER: { stateNext:  statusNext: ${change.nextState.status}, authUserNext: ${change.nextState.authUser} }');
  }
}