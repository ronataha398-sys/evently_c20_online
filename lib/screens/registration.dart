import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/screens/auth.dart';
import 'package:evently/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/AppColor.dart';
import '../google/google_auth.dart';

class Registration extends StatelessWidget {
  Registration({super.key});

  static const String routName = "Registration";

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Image.asset(
            "assets/logo/img.png",
            width: 142,
            height: 27,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48),

                Text(
                  AppLocalizations.of(context)!.createYourAccount,
                  style: theme.textTheme.bodyLarge,
                ),

                SizedBox(height: 24),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText:
                    AppLocalizations.of(context)!.enterYourName,
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText:
                    AppLocalizations.of(context)!.enterYourEmail,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText:
                    AppLocalizations.of(context)!.enterYourPassword,
                    prefixIcon: Icon(Icons.lock_outlined),
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!
                        .confirmYourPassword,
                    prefixIcon: Icon(Icons.lock_outlined),
                  ),
                ),

                SizedBox(height: 32),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      minimumSize: Size(343, 48),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final result = await Auth.createAccount(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                        );

                        if (result != null) {
                          print("Create Account Success");
                        }
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signUp,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightBgColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .alreadyHaveAnAccount,
                      style: theme.textTheme.titleSmall,
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Login.routName,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: theme.textTheme.titleLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: theme.canvasColor,
                        thickness: 1,
                      ),
                    ),

                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Or",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),

                    Expanded(
                      child: Divider(
                        color:theme.canvasColor,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 36),

                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () async {
                      final result =
                      await GoogleAuth.signInWithGoogle();

                      if (result != null) {
                        print("Google Sign In Success");
                      }
                    },
                    child: Container(

                      width: 343,
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline,
                          width: 1,
                        ),color:theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/logo/img_3.png",
                            width: 24,
                            height: 24,
                          ),

                          SizedBox(width: 16),

                          Text(
                            "Sign up with Google",
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}