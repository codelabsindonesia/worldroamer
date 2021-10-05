

part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure, }
class LoginState {
  LoginState({
    this.status = LoginStatus.initial,
    this.message = '',
    this.loginModel,
  });

  LoginStatus status;
  String message;
  LoginModel? loginModel;


  LoginState copyWith({
    LoginStatus? status,
    String? message,
    LoginModel? loginModel,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      loginModel: loginModel
    );
  }
}