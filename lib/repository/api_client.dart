
import 'package:codelabs_sample/ui/login/data/login_model.dart';
import 'package:codelabs_sample/ui/login/params/login_param.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'apis.dart';

part 'api_client.g.dart';

//run -> flutter pub run build_runner build --delete-conflicting-outputs

@RestApi(baseUrl: "https://reqres.in/api")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(Apis.login)
  Future<LoginModel> doLogin(@Body() LoginParam loginParam);

}
