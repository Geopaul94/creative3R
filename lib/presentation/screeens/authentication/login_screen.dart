import 'package:creative/data/models/userModel/authentication_model.dart';
import 'package:creative/presentation/bloc/authentication/login/login_bloc.dart';
import 'package:creative/presentation/bloc/authentication/login/login_event.dart';
import 'package:creative/presentation/bloc/authentication/login/login_state.dart';
import 'package:creative/presentation/screeens/authentication/forgot_password_screen.dart';
import 'package:creative/presentation/screeens/bottom_navigation.dart';
import 'package:creative/presentation/widgets/custom_elevated_button.dart';
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/presentation/widgets/custome_snackbar.dart';
import 'package:creative/presentation/widgets/custometextformfield.dart';
import 'package:creative/presentation/widgets/validations%20copy.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phonenumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSucessState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  BottomNavigationDrop()),
            );

            customSnackbar(context, 'Have a good trade ', Colors.yellow);

            _passwordController.clear();
            _phonenumberController.clear();
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText(
                  text: state.error,
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: black,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Aurify',
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.yellow,
                          ),
                          Lottie.asset(
                            'assets/animation/gold.json',
                            width: 250,
                          ),
                          CustomTextFormField(
                            keyboardType: TextInputType.phone,
                            labelText: 'Phone number',
                            hintText: 'Enter your phone number',
                            icon: Icons.email_outlined,
                            controller: _phonenumberController,
                            validator: validateMobileNumber,
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            icon: Icons.lock,
                            controller: _passwordController,
                            obscureText: true,
                            validator: validatePassword,
                          ),
                          h20,
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoadingState) {
                                return const CircularProgressIndicator();
                              }
                              return CustomGradientButton(
                                width: double.infinity,
                                text: 'Log in',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final UserAuthenticationModel user =
                                        UserAuthenticationModel(
                                      phonenumber: _phonenumberController.text,
                                      password: _passwordController.text,
                                    );

                                    context.read<LoginBloc>().add(
                                        OnLogingButtonPressedEvent(
                                            userAuthenticationModel: user));
                                    print('Login pressed');
                                  }
                                  FocusScope.of(context).unfocus();
                                },
                                height: 60,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                gradientColors: const [
                                  Color.fromARGB(255, 7, 218, 7),
                                  Colors.purple
                                ],
                              );
                            },
                          ),
                          h10,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "Forgot ",
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                                CustomText(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen()),
                                    );
                                  },
                                  text: "password?",
                                  fontSize: 20,
                                  color: Color(0xFFFFD700), // Golden color
                                  fontWeight: FontWeight.bold,
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
