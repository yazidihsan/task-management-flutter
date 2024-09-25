import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management/common_widgets/custom_button.dart';
import 'package:tasks_management/common_widgets/custom_loading_button.dart';
import 'package:tasks_management/common_widgets/custom_text_field.dart';
import 'package:tasks_management/features/auth/cubit/auth_cubit.dart';
import 'package:tasks_management/features/auth/models/auth_model.dart';
import 'package:tasks_management/theme_manager/color_manager.dart';
import 'package:tasks_management/theme_manager/font_family_manager.dart';
import 'package:tasks_management/theme_manager/space_manager.dart';
import 'package:tasks_management/theme_manager/value_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool _obscureText = true;
  bool isLoading = false;

  String? message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                      90.0.spaceY,
                      Text("Register Now!",
                          style:
                              blackExtraBoldTextStyle.copyWith(fontSize: 32)),
                      26.5.spaceY,
                      Text(
                        "Register your account below",
                        style: grey400SemiBoldTextStyle.copyWith(fontSize: 17),
                      ),
                      36.5.spaceY,
                      CustomTextField(
                        controller: userController,
                        title: "Username",
                        hintText: "Enter Username",
                      ),
                      20.0.spaceY,
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
                            Navigator.pop(context);
                          }
                          // TODO: implement listener
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
                                  if (userController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor:
                                              ColorManager.secondary,
                                          content: const Text(
                                              'user anda belum diisi!')),
                                    );
                                    return;
                                  }
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

                                  context.read<AuthCubit>().register(AuthModel(
                                      name: userController.text,
                                      email: emailController.text,
                                      password: passController.text));
                                },
                                title: "Register");
                          },
                        ),
                      ),
                      24.0.spaceY,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: blackMediumTextStyle.copyWith(fontSize: 14),
                          ),
                          4.0.spaceX,
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Login here",
                                style: blueLinkTextStyle.copyWith(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      )
                    ]))));
  }
}
