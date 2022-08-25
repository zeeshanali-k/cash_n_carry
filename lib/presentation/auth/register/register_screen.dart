import 'package:cash_n_carry/presentation/auth/components/auth_button.dart';
import 'package:cash_n_carry/presentation/auth/components/auth_password_field.dart';
import 'package:cash_n_carry/presentation/auth/components/auth_text_field.dart';
import 'package:cash_n_carry/presentation/auth/components/top_bg.dart';
import 'package:cash_n_carry/presentation/auth/register/register_bloc.dart';
import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:cash_n_carry/utils/di/cash_n_carry_di.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late RegisterState? authState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => getIt<RegisterBloc>(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (_, state) {
          if (state is RegisterResponse && state.error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          } else if (state is RegisterResponse && state.success) {
            Fluttertoast.showToast(
                msg: "Registered",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                gravity: ToastGravity.TOP);
            Navigator.of(context).pop();
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
              Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.all(18.0),
                alignment: Alignment.center,
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
                          child:
                              Center(child: Image.asset(AppConstants.appLogo)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Form
                    Expanded(
                      flex: 3,
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
                          AuthTextField(
                              textEditingController: nameController,
                              hint: "Full Name",
                              error: "Enter valid Name",
                              prefixIcon: Icons.person),
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
                            return BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (bContext, state) {
                                return (state is RegisterInitial ||
                                        state is RegisterResponse)
                                    ? Column(
                                        children: [
                                          AuthButton(
                                              title: "Register",
                                              clickListener: () {
                                                if (!formKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                bContext
                                                    .read<RegisterBloc>()
                                                    .add(RegisterUserEvent(
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        name: nameController
                                                            .text));
                                              }),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          AuthButton(
                                              title: "Login",
                                              clickListener: () {
                                                Navigator.of(context).pop();
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
            ]),
          ),
        ),
      ),
    );
  }
}
