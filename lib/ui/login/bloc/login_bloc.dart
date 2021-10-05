import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:codelabs_sample/repository/api_client.dart';
import 'package:codelabs_sample/ui/login/data/login_model.dart';
import 'package:codelabs_sample/ui/login/params/login_param.dart';
import 'package:dio/dio.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event) async* {
    if (event is LoginFetched) {
      yield await _setLoading(event, state);
      yield await _mapLoginFetchedToState(event, state);
    }
  }

  Future<LoginState> _setLoading(
      LoginFetched event, LoginState state) async {
    return state.copyWith(
      status: LoginStatus.loading,
    );
  }

  Future<LoginState> _mapLoginFetchedToState(
      LoginFetched event, LoginState state) async {
    try {
      final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
      var data = await client.doLogin(event.loginParam);

      return state.copyWith(
        status: LoginStatus.success,
        loginModel: data,
        message: 'login successfully',
      );
    } on Exception catch (ex) {
      if (ex is DioError) {
        try {
          print('error : '+ ex.response.toString());
          if(ex.response != null) {
            var error = jsonDecode(ex.response.toString());
            return state.copyWith(
                status: LoginStatus.failure, message: error["error"]);
          }else{
            return state.copyWith(status: LoginStatus.failure, message: ex.toString());
          }
        } on Exception catch (e) {
          return state.copyWith(status: LoginStatus.failure, message: e.toString());
        }
      } else {
        return state.copyWith(status: LoginStatus.failure, message: ex.toString());
      }
    }
  }
}
