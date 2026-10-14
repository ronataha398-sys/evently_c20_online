import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth {
static Future<User?> createAccount({
required String email,
required String password,
required String name,
}) async {
try {
final credential =
await FirebaseAuth.instance.createUserWithEmailAndPassword(
email: email,
password: password,
);

await credential.user?.updateProfile(displayName: name);
await credential.user?.updateDisplayName(name);

return credential.user;
} on FirebaseAuthException catch (e) {
if (e.code == 'weak-password') {
throw 'The password provided is too weak.';
} else if (e.code == 'email-already-in-use') {
throw 'The account already exists for that email.';
} else {
throw e.message ?? "";
}
}
}

static Future<User?> Login({
required String email,
required String password,
required BuildContext context,
}) async {
try {
final credential =
await FirebaseAuth.instance.signInWithEmailAndPassword(
email: email,
password: password,
);

return credential.user;
} on FirebaseAuthException catch (e) {
print("LOGIN ERROR: ${e.code}");
print("LOGIN MESSAGE: ${e.message}");

throw "Invalid email or password";
}
}
}
