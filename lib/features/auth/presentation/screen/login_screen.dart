import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management/common_widgets/custom_button.dart';
import 'package:tasks_management/common_widgets/custom_loading_button.dart';
import 'package:tasks_management/common_widgets/custom_text_field.dart';
import 'package:tasks_management/features/auth/cubit/auth_cubit.dart';
import 'package:tasks_management/features/auth/models/auth_model.dart';
import 'package:tasks_management/features/auth/presentation/screen/register_screen.dart';
import 'package:tasks_management/features/tasks/presentation/screen/main_screen.dart';
import 'package:tasks_management/theme_manager/color_manager.dart';
import 'package:tasks_management/theme_manager/font_family_manager.dart';
import 'package:tasks_management/theme_manager/space_manager.dart';
import 'package:tasks_management/theme_manager/value_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'yazid@gmail.com');
  TextEditingController passController =
      TextEditingController(text: 'password123');

  bool _obscureText = true;
  bool isLoading = false;

  String? message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _toggleVisibilty() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      120.0.spaceY,
                      Text("Welcome back!",
                          style:
                              blackExtraBoldTextStyle.copyWith(fontSize: 32)),
                      26.5.spaceY,
                      Text(
                        "Login below",
                        style: grey400SemiBoldTextStyle.copyWith(fontSize: 17),
                      ),
                      36.5.spaceY,
                      CustomTextField(
                        controller: emailController,
                        title: "Email",
                        hintText: "Enter Email",
                      ),
                      20.0.spaceY,
                      CustomTextField(
                        controller: passController,
                        title: "Password",
                        hintText: "Enter Password",
                        obscureText: _obscureText,
                        suffixIcon: IconButton(
                            onPressed: _toggleVisibilty,
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                      54.0.spaceY,
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is AuthFailed) {
                            String message = state.message;
                            if (message.isNotEmpty) {
                              ValueManager.customToast(message);
                            }
                          }

                          if (state is AuthSuccess) {
                            String message = state.message;
                            if (message.isNotEmpty) {
                              ValueManager.customToast(message);
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen()));
                          }
                        },
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(
                                child: CustomLoadingButton(),
                              );
                            }

                            return CustomButton(
                                onPressed: () {
                                  if (emailController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor:
                                              ColorManager.secondary,
                                          content: const Text(
                                              'email anda belum diisi!')),
                                    );
                                    return;
                                  }
                                  if (passController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor:
                                              ColorManager.secondary,
                                          content: const Text(
                                              'password anda belum diisi!')),
                                    );
                                    return;
                                  }
                                  context.read<AuthCubit>().login(AuthModel(
                                      email: emailController.text,
                                      password: passController.text));
                                },
                                title: "Login");
                          },
                        ),
                      ),
                      24.0.spaceY,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: blackMediumTextStyle.copyWith(fontSize: 14),
                          ),
                          4.0.spaceX,
                          TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen())),
                              child: Text(
                                "Register here",
                                style: blueLinkTextStyle.copyWith(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      )
                    ]))));
  }
}
