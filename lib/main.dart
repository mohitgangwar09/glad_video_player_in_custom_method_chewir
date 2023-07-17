import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/screen/auth_screen/splash_screen.dart';
import 'package:glad/theme/light_theme.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (context) => di.sl<AuthCubit>())],
    child: GetMaterialApp(
        theme: light, debugShowCheckedModeBanner: false, home: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
