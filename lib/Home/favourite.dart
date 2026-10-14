import 'package:evently/main.dart';
import 'package:evently/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              // ================= PROFILE IMAGE =================

              const SizedBox(height: 32),

              Center(
                child: Image.asset(
                  "assets/image/img_5.png",
                  width: 104,
                  height: 104,
                ),
              ),

              const SizedBox(height: 16),

              // ================= NAME =================

              Text(
                user?.displayName ?? "User",
                style: theme.textTheme.bodyLarge,
              ),

              const SizedBox(height: 4),

              // ================= EMAIL =================

              Text(
                user?.email ?? "",
                style: theme.textTheme.bodySmall,
              ),

              const SizedBox(height: 32),

              // ================= DARK MODE =================

              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.cardColor,
                ),
                child: Row(
                  children: [
                    Text(
                      "Dark mode",
                      style: theme.textTheme.titleMedium,
                    ),

                    const Spacer(),

                    ValueListenableBuilder(
                      valueListenable: themeMode,
                      builder: (context, value, child) {
                        return Switch(
                          value: value == ThemeMode.dark,
                          onChanged: (value) {
                            themeMode.value = value
                                ? ThemeMode.dark
                                : ThemeMode.light;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 13),

              // ================= LANGUAGE =================

              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Language"),

                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            // English
                            ListTile(
                              title: const Text("English"),
                              onTap: () {
                                locale.value = const Locale("en");
                                Navigator.pop(context);
                              },
                            ),

                            // Arabic
                            ListTile(
                              title: const Text("العربية"),
                              onTap: () {
                                locale.value = const Locale("ar");
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },

                borderRadius: BorderRadius.circular(12),

                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [
                      Text(
                        "Language",
                        style: theme.textTheme.titleMedium,
                      ),

                      const Spacer(),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 13),

              // ================= LOGOUT =================

              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  if (!mounted) return;

                  Navigator.pushReplacementNamed(
                    context,
                    Login.routName,
                  );
                },

                borderRadius: BorderRadius.circular(12),

                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [
                      Text(
                        "Logout",
                        style: theme.textTheme.titleMedium,
                      ),

                      const Spacer(),

                      const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                    ],
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