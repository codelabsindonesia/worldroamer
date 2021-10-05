import 'package:codelabs_sample/ui/login/login_page.dart';
import 'package:codelabs_sample/utils/app_color.dart';
import 'package:codelabs_sample/utils/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 3000), () {
        AppNavigator().pushReplacement(context, child: const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.white,
            AppColor.white,
          ],
        )),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Center(child: Image.asset('assets/images/logo.png', width: 32.w,)),
            ),
            Container(
                width: double.infinity,
                height: 1.2.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bottom_splash.png"),
                        fit: BoxFit.fitHeight)
                )
            ),
          ],
        ),
      ),
    );
  }
}
