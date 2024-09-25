import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_management/features/auth/cubit/auth_cubit.dart';
import 'package:tasks_management/features/auth/data/data_provider/auth_data_provider.dart';
import 'package:tasks_management/features/auth/data/repository/auth_repository.dart';
import 'package:tasks_management/features/splash/presentation/screen/splash_screen.dart';
import 'package:tasks_management/features/tasks/cubit/tasks_cubit.dart';
import 'package:tasks_management/features/tasks/data/data_provider/tasks_data_provider.dart';
import 'package:tasks_management/features/tasks/data/repository/tasks_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    // ValueManager.customToast('Environment variables loaded successfully');
  } catch (e) {
    // ValueManager.customToast('Error loading environment variables: $e');
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final client = http.Client();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthCubit(AuthRepository(AuthDataProvider(client))),
        ),
        BlocProvider(
          create: (context) =>
              TasksCubit(TasksRepository(TasksDataProvider(client))),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
    );
  }
}
