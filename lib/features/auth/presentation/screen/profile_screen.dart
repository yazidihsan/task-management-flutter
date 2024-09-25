import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_management/common_widgets/custom_button.dart';
import 'package:tasks_management/common_widgets/custom_loading_button.dart';
import 'package:tasks_management/features/auth/cubit/auth_cubit.dart';
import 'package:tasks_management/features/auth/presentation/screen/login_screen.dart';
import 'package:tasks_management/theme_manager/color_manager.dart';
import 'package:tasks_management/theme_manager/font_family_manager.dart';
import 'package:tasks_management/theme_manager/space_manager.dart';
import 'package:tasks_management/theme_manager/value_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.tab});

  final int tab;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final pref = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Screen',
          style: blackExtraBoldTextStyle.copyWith(fontSize: 32),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            40.0.spaceY,
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthProfileLoaded) {
                  String name = state.user.name;
                  String email = state.user.email;
                  return Column(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.person,
                          size: 24,
                          color: ColorManager.blackBold,
                        ),
                      ),
                      24.0.spaceY,
                      Text(
                        name,
                        style: blackMediumTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      10.0.spaceY,
                      Text(
                        email,
                        style: blackMediumTextStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  );
                }
                return Text(
                  'data profile tidak ada',
                  style: blackMediumTextStyle.copyWith(fontSize: 12),
                );
              },
            ),
            32.0.spaceY,
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: CustomButton(
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                        },
                        title: 'Logout'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
