import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_1pm/core/theme/app_theme.dart';
import 'package:todo_1pm/modules/layout/layout_screen.dart';
import 'package:todo_1pm/modules/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'firebase_options.dart';
import 'modules/auth/pages/create_account_screen.dart';
import 'modules/auth/pages/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFires
  // tore.instance.disableNetwork();

  runApp(EasyLocalization(
      path: "assets/translations",
      supportedLocales: const [
        Locale("ar"),
        Locale("en"),
      ],
      saveLocale: true,
      startLocale: const Locale("en"),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LayoutScreen.routeName: (_) => const LayoutScreen(),
        CreateAccountScreen.routeName: (_) => const CreateAccountScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
