import 'package:evently/Home/home_screen.dart';
import 'package:evently/forget_password/ResetPassword.dart';
import 'package:flutter/material.dart';

import '../colors/AppColor.dart';
import '../l10n/app_localizations.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});
  static const String routName="ForgetPassword";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        useDefaultSemanticsOrder: true,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.forgetPasswordTitle,
          style: theme.textTheme.titleMedium,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(height: 32),
          Center(
            child: Image.asset(
              "assets/image/img_3.png",
              width: 343,
              height: 343,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 49,),
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
                      return Resetpassword();
                    },
                  ),
                );
              },

              child: Text(
                AppLocalizations.of(context)!.resetPassword,
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