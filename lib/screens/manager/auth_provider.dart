import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../auth.dart';

class AuthProvider extends ChangeNotifier {
bool isLoading = false;
User? user;

String? errorMessage;

Future<void> createAccount({
required String email,
required String password,
required String name,
required BuildContext context,
}) async {
isLoading = true;
errorMessage = null;
notifyListeners();

try {
user = await Auth.createAccount(
email: email,
password: password,
name: name,
);
} catch (e) {
errorMessage = e.toString().replaceFirst('Exception: ', '');
}

isLoading = false;
notifyListeners();
}

Future<void> Login({
required String email,
required String password,
required BuildContext context,
}) async {
isLoading = true;
errorMessage = null;
notifyListeners();

try {
user = await Auth.Login(
email: email,
password: password,
context: context,
);
} catch (e) {
errorMessage = e.toString().replaceFirst('Exception: ', '');
}

isLoading = false;
notifyListeners();
}
}
