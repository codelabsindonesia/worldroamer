
import 'package:codelabs_sample/ui/home/home_page.dart';
import 'package:codelabs_sample/ui/login/params/login_param.dart';
import 'package:codelabs_sample/utils/app_color.dart';
import 'package:codelabs_sample/utils/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:sizer/sizer.dart';

import 'bloc/login_bloc.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  late TextEditingController _emailController;
  late TextEditingController _passController;


  late LoginBloc _loginBloc;


  CustomProgressDialog? _progressDialog;
  
  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passController = TextEditingController();

    _loginBloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (_progressDialog == null || _progressDialog?.isShowed == false) {
              _progressDialog = CustomProgressDialog(context,dismissable: false);
              _progressDialog?.setLoadingWidget(Container(
                padding: EdgeInsets.all(8.w),
                width: 35.w,
                height: 35.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.blueAccent)),
                    SizedBox(
                      height: 5.w,
                    ),
                    Text(
                      'Loading ...',
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ));
            }

            switch (state.status) {
              case LoginStatus.loading:
                _progressDialog?.show();
                break;

              case LoginStatus.failure:
                _progressDialog?.dismiss();

                _openDialogAlert(state.message, () {});

                break;

              case LoginStatus.success:
                _progressDialog?.dismiss();

                // print('success');
                AppNavigator().push(context, child: const HomePage());

                break;

              default:
                break;
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    AppNavigator().push(context, child: const HomePage());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/ic_close.png', width: 2.w,),
                      SizedBox(width:1.w),
                      Text('Skip', style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.gray),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h, child: Center(child: Image.asset('assets/images/logo.png', width: 28.w,))),
              TextField(
                controller: _emailController,
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height:2.h),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {

                  },
                  child: Text('Forgot password?',
                    style:TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blue
                  ),),
                ),
              ),
              TextField(
                controller: _passController,
                obscureText: true,
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height:4.h),
              InkWell(
                onTap:(){
                  var email = _emailController.text;
                  var pass = _passController.text;

                  if(email.isEmpty){
                    Fluttertoast.showToast(
                        msg: "Please enter email address",
                        gravity: ToastGravity.CENTER,
                        fontSize: 10.sp
                    );
                    return;
                  }

                  if(pass.isEmpty){
                    Fluttertoast.showToast(
                        msg: "Please enter password",
                        gravity: ToastGravity.CENTER,
                        fontSize: 10.sp
                    );
                    return;
                  }

                  LoginParam loginParam = LoginParam(
                    email: email,
                    password:pass,
                  );

                  _loginBloc.add(LoginFetched(loginParam));
                },
                child: Container(
                  width: 70.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:AssetImage("assets/images/btn_login.png"),
                          fit:BoxFit.fitWidth
                      ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom:1.h),
                      child: Text('Log In',
                        style:TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account yet?', style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.gray),),
                      SizedBox(width:1.w),
                      InkWell(
                        onTap: (){

                        },
                        child: Text('Sign up', style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.purple),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openDialogAlert(String msg, Function onYes) async {
    await NAlertDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.w),
        child: Text(
          "Message",
          style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Text(
          msg,
          style: TextStyle(
              color: Colors.black,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Text(
              "OK",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.pop(context);
              onYes();
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ))),
      ],
    ).show(context);
  }

}
