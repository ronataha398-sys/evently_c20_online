import 'package:animate_do/animate_do.dart';
import 'package:evently/colors/AppColor.dart';
import 'package:evently/onboarding/onboarding_light.dart';
import 'package:evently/Home/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
const Splash({super.key});

static const String routName = "Splash";

@override
State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
@override
void initState() {
super.initState();
checkUser();
}

Future<void> checkUser() async {
await Future.delayed(const Duration(seconds: 3));

if (!mounted) return;

final user = FirebaseAuth.instance.currentUser;

if (user != null) {
Navigator.pushReplacementNamed(
context,
Layout.routName
);
} else {
Navigator.pushReplacementNamed(
context,
OnboardingLight.routName,
);
}
}

@override
Widget build(BuildContext context) {
var theme = Theme.of(context);

return Scaffold(
backgroundColor: AppColors.lightBgColor,
body: SafeArea(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Expanded(
child: Center(
child: FlipInX(
child: Image.asset(
"assets/logo/img.png",
width: 309,
height: 58,
color: theme.primaryColor,
),
),
),
),
Center(
child: FlipInX(
child: Image.asset(
"assets/logo/img_1.png",
width: 214,
color: theme.primaryColor,
),
),
),
],
),
),
);
}
}
