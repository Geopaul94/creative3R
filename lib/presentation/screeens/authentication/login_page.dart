import 'package:creative/presentation/bloc/authentication/login/login_bloc.dart';
import 'package:creative/presentation/screeens/authentication/forgot_password.dart';
import 'package:creative/presentation/widgets/custom_elevated_button.dart';
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/presentation/widgets/custometextformfield.dart';
import 'package:creative/presentation/widgets/validations%20copy.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: Scaffold(
        backgroundColor: black,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        CustomTextFormField(
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
                        const SizedBox(height: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomGradientButton(
                      text: 'Log in',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Add your login logic here
                          print('Login pressed');
                        }
                      },
                      width: 250,
                      height: 60,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      gradientColors: const [Colors.blue, Colors.purple],
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Forgot password?  ",
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          const SizedBox(width: 5),
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
  }
}
