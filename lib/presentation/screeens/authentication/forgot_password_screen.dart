import 'package:creative/data/models/userModel/authentication_model.dart';
import 'package:creative/presentation/bloc/authentication/login/login_bloc.dart';
import 'package:creative/presentation/bloc/authentication/login/login_event.dart';
import 'package:creative/presentation/bloc/authentication/login/login_state.dart';
import 'package:creative/presentation/screeens/authentication/login_screen.dart';
import 'package:creative/presentation/widgets/custom_elevated_button.dart';
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/presentation/widgets/custome_snackbar.dart';
import 'package:creative/presentation/widgets/custometextformfield.dart';
import 'package:creative/presentation/widgets/validations%20copy.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:creative/utilities/functions/void_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _confirmpasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ForgotPasswordErrorState) {
            customSnackbar(context, state.error, red);
          }

          if (state is ForgotPasswordSucessState) {
            customSnackbar(context, 'Password updated successfully', green);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: black,
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 25.h,
                    left: 10.w,
                    child: GestureDetector(
                      onTap: () {
                        print('object                     22');
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(155, 48, 43, 43),
                        child: Center(
                            child: Icon(CupertinoIcons.back,
                                color: Colors.white, size: 30.sp)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: 'Aurify',
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                          // Lottie.asset(
                          //   'assets/animation/gold3.json',
                          //   width: 60.w,
                          //   height: 60.h,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Opacity(
                      opacity: 0.25,
                      child: Lottie.asset(
                        'assets/animation/gold4.json',
                        width: 800.w,
                        height: 800.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              resetPasswordText(),
                              h10,
                              CustomTextFormField(
                                keyboardType: TextInputType.phone,
                                labelText: 'Phone number',
                                hintText: 'Enter your phone number',
                                icon: Icons.email_outlined,
                                controller: _phoneNumberController,
                                validator: validateMobileNumber,
                              ),
                              h20,
                              CustomTextFormField(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                icon: Icons.lock,
                                controller: _passwordController,
                                obscureText: true,
                                validator: validatePassword,
                              ),
                              h20,
                              CustomTextFormField(
                                labelText: 'Confirm Password',
                                hintText: 'Confirm  password',
                                icon: Icons.lock,
                                controller: _confirmpasswordController,
                                validator: validatePassword,
                                obscureText: true,
                              ),
                              h20,
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state is ForgotPasswordLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return resetPassword(context);
                                },
                              ),
                              h10,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row resetPasswordText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Reset Password',
              fontSize: 30,
              color: grey,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text: 'Enter your phone number  and new \npassword',
              fontSize: 20,
              color: grey,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ],
    );
  }

  CustomGradientButton resetPassword(BuildContext context) {
    return CustomGradientButton(
      text: 'Reset Password',
      onPressed: () {
        if (_passwordController.text != _confirmpasswordController.text) {
          showCustomSnackBar(context, 'Password does not match',
              backgroundColor: red);
        }
        if (_formKey.currentState!.validate() &&
            _passwordController.text == _confirmpasswordController.text) {
          final UserAuthenticationModel user = UserAuthenticationModel(
              phonenumber: _phoneNumberController.text,
              password: _passwordController.text);
          print('Reset pressed');

          context
              .read<LoginBloc>()
              .add(OnForgotPasswordButtonPressedEvent(forgotpassowrd: user));
        }
      },
      width: double.infinity,
      height: 60,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      gradientColors: [
        Colors.grey[900]!,
        Colors.amber[700]!,
        Colors.amber[400]!,
      ],
    );
  }
}
