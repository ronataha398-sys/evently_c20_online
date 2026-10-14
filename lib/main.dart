import 'package:evently/add/adds.dart';
import 'package:evently/colors/App_theme.dart';
import 'package:evently/event_modele.dart';
import 'package:evently/forget_password/forget_password.dart';
import 'package:evently/screens/login.dart';
import 'package:evently/screens/registration.dart';
import 'package:evently/splash/splash.dart';
import 'package:evently/tabs/event_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'onboarding/onboarding_light.dart';

ValueNotifier themeMode = ValueNotifier(ThemeMode.light);
ValueNotifier locale = ValueNotifier(Locale("en"));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static var appKey = Key("theme");

  static updateScreen() {
    appKey = ValueKey(themeMode);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeMode,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: locale,
          builder: (context, value, child) {
            return MaterialApp(
              routes: {
                Splash.routName: (_) => Splash(),
                ForgetPassword.routName: (_) => ForgetPassword(),
                Registration.routName: (_) => Registration(),
                Login.routName: (_) => Login(),
                OnboardingLight.routName: (_) => OnboardingLight(),
                Adds.routName: (_) => Adds(),

                EventDetails.routName: (context) {
                  final event = ModalRoute.of(context)!
                      .settings.arguments as EventModel;

                  return EventDetails(event: event);
                },
              },
              initialRoute: Splash.routName,
              locale: locale.value,
              localizationsDelegates: [
                AppLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              supportedLocales: [
                Locale('en'),
                Locale('ar'),
              ],
              themeMode: themeMode.value,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}