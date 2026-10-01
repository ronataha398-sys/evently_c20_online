import 'package:animate_do/animate_do.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/main.dart';
import 'package:evently/onboarding/OnboardingLight3.dart';
import 'package:evently/onboarding/selected.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../colors/AppColor.dart';

class OnboardingLight2 extends StatefulWidget {
  const OnboardingLight2({super.key});
  static const String routName="onboardingLight";


  @override
  State<OnboardingLight2> createState() => _OnboardingLightState();
}

class _OnboardingLightState extends State<OnboardingLight2> {
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
              "assets/image/img_5.png",
              width: 343,
              color: theme.primaryColorLight,
            ),
          ),

          SizedBox(height: 24),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppLocalizations.of(context)!.first,
              style: theme.textTheme.titleMedium,
            ),
          ),

          SizedBox(height: 8),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context)!.desTitle3,
              style: theme.textTheme.titleSmall,
            ),
          ),

          SizedBox(height: 30),

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
                      return OnboardingLight3();
                    },
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.next,
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