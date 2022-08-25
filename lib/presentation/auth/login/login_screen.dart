import 'package:cash_n_carry/domain/models/user.dart';
import 'package:cash_n_carry/presentation/auth/components/auth_button.dart';
import 'package:cash_n_carry/presentation/auth/components/auth_password_field.dart';
import 'package:cash_n_carry/presentation/auth/components/auth_text_field.dart';
import 'package:cash_n_carry/presentation/auth/components/top_bg.dart';
import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:cash_n_carry/utils/constants/pref_constants.dart';
import 'package:cash_n_carry/utils/constants/screens.dart';
import 'package:cash_n_carry/utils/di/cash_n_carry_di.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AuthState? authState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthResponse && state.error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          } else if (state is AuthResponse && state.user != null) {
            saveUserAndProceed(context, state.user!);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.backgroundColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
            toolbarHeight: 0,
            elevation: 0,
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            width: size.width,
            color: Colors.white,
            child: Stack(children: [
              Align(
                heightFactor: 0.1,
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.1,
                  child: CustomPaint(
                    painter: TopBg(),
                    size: Size(size.width, size.height * 0.1),
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Image.asset(AppConstants.appLogo)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Form
                        Expanded(
                          flex: 2,
                          child: Form(
                            key: formKey,
                            child: Column(children: [
                              AuthTextField(
                                  textEditingController: emailController,
                                  hint: "Email",
                                  error: "Enter valid Email Address",
                                  prefixIcon: Icons.email),
                              const SizedBox(
                                height: 20,
                              ),
                              AuthPasswordField(
                                  textEditingController: passwordController),
                            ]),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //Buttons
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Builder(
                              builder: (bContext) {
                                return BlocBuilder<AuthBloc, AuthState>(
                                  builder: (bContext, state) {
                                    return (state is AuthInitial ||
                                            state is AuthResponse)
                                        ? Column(
                                            children: [
                                              AuthButton(
                                                  title: "Login",
                                                  clickListener: () {
                                                    if (!formKey.currentState!
                                                        .validate()) {
                                                      return;
                                                    }
                                                    bContext
                                                        .read<AuthBloc>()
                                                        .add(LoginEvent(
                                                            email:
                                                                emailController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text));
                                                  }),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              AuthButton(
                                                  title: "Register",
                                                  clickListener: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            ScreenRegister()
                                                                .route);
                                                  })
                                            ],
                                          )
                                        : const CircularProgressIndicator();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // const Expanded(flex: 1, child: SizedBox())
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void saveUserAndProceed(BuildContext context, User user) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(PrefContants.userId, user.id);
    sp.setString(PrefContants.userName, user.name);
    sp.setString(PrefContants.userEmail, user.email);
    sp.setBool(PrefContants.isLoggedIn, true);
    Navigator.of(context).popAndPushNamed(ScreenHome().route);
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
