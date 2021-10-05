import 'package:codelabs_sample/ui/login/bloc/login_bloc.dart';
import 'package:codelabs_sample/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'login_content.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return Scaffold(
            resizeToAvoidBottomInset: true,
            body: MultiBlocProvider(
              providers: [
                BlocProvider<LoginBloc>(
                  create: (_) => LoginBloc(),
                ),
              ],
              child: const SafeArea(child: LoginContent()),
            ),
          );
      },

    );
  }
}
