import 'package:cash_n_carry/utils/constants/pref_constants.dart';
import 'package:cash_n_carry/utils/constants/screens.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    proceed(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        color: AppColors.backgroundColor,
        child: Image(
          image: Image.asset("assets/images/logo.png").image,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  void proceed(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    if (sp.getBool(PrefContants.isLoggedIn) ?? false) {
      Navigator.of(context).popAndPushNamed(ScreenHome().route);
    } else {
      Navigator.of(context).popAndPushNamed(ScreenLogin().route);
    }
  }
}
