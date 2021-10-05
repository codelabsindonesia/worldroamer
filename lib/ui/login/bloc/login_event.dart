
part of 'login_bloc.dart';
abstract class LoginEvent{}

class LoginFetched extends LoginEvent {
  LoginFetched(this.loginParam);

  LoginParam loginParam;
}