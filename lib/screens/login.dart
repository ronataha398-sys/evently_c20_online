import 'package:evently/Home/layout.dart';
import 'package:evently/colors/AppColor.dart';
import 'package:evently/forget_password/forget_password.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/screens/auth.dart';
import 'package:evently/screens/registration.dart';
import 'package:flutter/material.dart';

import '../google/google_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const String routName = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        useDefaultSemanticsOrder: true,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Image.asset("assets/logo/img.png", width: 142, height: 27),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              Text(
                AppLocalizations.of(context)!.loginToYourAccount,
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterYourEmail,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterYourPassword,
                  prefixIcon: Icon(Icons.lock_outlined),
                ),
              ),
              if (errorMessage != null) ...[
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              ],
              SizedBox(height: 8),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      ForgetPassword.routName,
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    style: theme.textTheme.titleLarge!.copyWith(
                      decoration: TextDecoration.underline,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    minimumSize: Size(343, 48),
                  ),
                  onPressed: () async {
                    setState(() {
                      errorMessage = null;
                    });
                    try {
                      final result = await Auth.Login(
                        email: emailController.text.trim(),
                        password: passwordController.text,
                        context: context,
                      );
                      print("USER: $result");
                      if (result != null) {
                        print("Login Success");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Layout()),
                        );
                      }
                    } catch (e) {
                      print("LOGIN ERROR: $e");
                      setState(() {
                        errorMessage = e.toString();
                      });
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBgColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAnAccount,
                    style: theme.textTheme.titleSmall,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Registration.routName,
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signup,
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
                    child: Divider(color: theme.canvasColor, thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Or", style: theme.textTheme.bodyLarge),
                  ),
                  Expanded(
                    child: Divider(color: theme.canvasColor, thickness: 1),
                  ),
                  SizedBox(height: 36),
                ],
              ),
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () async {
                    final result = await GoogleAuth.signInWithGoogle();
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
                      ),
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo/img_3.png",
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Login with Google",
                          style: theme.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
