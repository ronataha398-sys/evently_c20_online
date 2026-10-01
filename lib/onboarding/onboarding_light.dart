import 'package:animate_do/animate_do.dart';
import 'package:evently/colors/AppColor.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/main.dart';
import 'package:evently/onboarding/onboarding_light1.dart';
import 'package:evently/onboarding/selected.dart';
import 'package:evently/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OnboardingLight extends StatefulWidget {
  const OnboardingLight({super.key});
  static const String routName="onboardingLight";


  @override
  State<OnboardingLight> createState() => _OnboardingLightState();
}

class _OnboardingLightState extends State<OnboardingLight> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),

          ZoomIn(
            child: Center(
              //logo
              child: Image.asset(
                "assets/logo/img.png",
                width: 142,
                height: 27,
                color: theme.primaryColor,
              ),
            ),
          ),

          SizedBox(height: 24),

          Center(
            child: Image.asset(
              "assets/image/img.png",
              width: 343,
              color: theme.primaryColorLight,
            ),
          ),

          SizedBox(height: 24),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppLocalizations.of(context)!.titleStart,
              style: theme.textTheme.titleMedium,
            ),
          ),

          SizedBox(height: 8),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context)!.desTitle,
              style: theme.textTheme.titleSmall,
            ),
          ),

          SizedBox(height: 30),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context)!.language,
                  style: theme.textTheme.titleLarge,
                ),
              ),

              SizedBox(width: 70),

              Selected(
                onTap: () {
                  setState(() {
                    locale.value = Locale("en");
                  });
                },
                title: AppLocalizations.of(context)!.english,
                isSelect: locale.value.languageCode == "en",
              ),

              SizedBox(width: 2),

              Selected(
                onTap: () {
                  setState(() {
                    locale.value = Locale("ar");
                  });
                },
                isSelect: locale.value.languageCode == "ar",
                title: AppLocalizations.of(context)!.arabic,
              ),
            ],
          ),

          SizedBox(width: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context)!.theme,
                  style: theme.textTheme.titleLarge,
                ),
              ),

              SizedBox(width: 100),

              Selected(
                onTap: () {
                  setState(() {
                    isDark = false;
                    themeMode.value = ThemeMode.light;
                  });
                },
                isSelect: !isDark,
                icon: "assets/image/img_2.png",
              ),

              Selected(
                onTap: () {
                  setState(() {
                    isDark = true;
                    themeMode.value = ThemeMode.dark;
                  });
                },
                isSelect: isDark,
                icon: "assets/image/img_1.png",
              ),
            ],
          ),

          SizedBox(height: 24),

          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                minimumSize: Size(343, 48),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OnboardingLight1();
                    },
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.letsStart,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBgColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}