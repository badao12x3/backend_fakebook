import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fakebook_frontend/blocs/auth/auth_event.dart';
import 'package:fakebook_frontend/blocs/auth/auth_state.dart';
import 'package:fakebook_frontend/models/auth_user_model.dart';
import 'package:fakebook_frontend/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository authRepository;

  AuthBloc(): super(AuthState.initial()) {
    authRepository = AuthRepository();

    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<KeepSession>(_checkAndKeepLoginSession);
  }

  // void async = Future<void> async
  void _onLogin(Login event, Emitter<AuthState> emit) async {
    final phone = event.phone;
    final password = event.password;
    try {
      final authUser = await authRepository.login(phone: phone, password: password);
      if(authUser.code == '1000' && authUser.message == 'OK') {
        emit(AuthState(status: AuthStatus.authenticated, authUser: authUser));
        // lưu thông tin user login vào local storage/cache để lấy id/token/name
        final userInfo = state.authUser;
        final _id = userInfo.id;
        final _name = userInfo.name;
        final _token = userInfo.token;
        Map<String, dynamic> user = {'id': _id, 'name': _name, 'token': _token};
        // print("#Auth_bloc: "+user.toString());
        final prefs = await SharedPreferences.getInstance();
        // editor có thể hiển thị &quot; hoặc "" ---> không ảnh hưởng gì
        await prefs.setString('user', jsonEncode(user));
      }
      if(authUser.code == '9995') {
        emit(AuthState(status: AuthStatus.unauthenticated, authUser: authUser));
      }
    } catch(_) {
      emit(state.copyWith(status: AuthStatus.unknown, authUser: AuthUser.initial()));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    // xóa thông tin user login ở local storage/cache
    final prefs = await SharedPreferences.getInstance();
    final successRemoveUserData = await prefs.remove('user');
    // print(successRemoveUserData);
    authRepository.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated, authUser: AuthUser.initial()));
  }

  void _checkAndKeepLoginSession(KeepSession event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    String? userPref = prefs.getString('user');
    if (userPref != null) {
      Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
      final _id = userMap['id'];
      final _name = userMap['name'];
      final _token = userMap['token'];
      emit(AuthState(status: AuthStatus.authenticated, authUser: AuthUser(code: '200', message: 'OK restore login session', id: _id, name: _name, token: _token, avatar: '', active: false)));
    }
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