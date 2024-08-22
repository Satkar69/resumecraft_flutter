import 'package:flutter/material.dart';

import 'package:resumecraft/pages/profile/profile_section.dart';
import 'package:resumecraft/pages/auth/login_page.dart';
import 'package:resumecraft/pages/home/home_page.dart';
import 'package:resumecraft/pages/profile_section/personal_detail.dart';
import 'package:resumecraft/pages/profile/profile_page.dart';
import 'package:resumecraft/pages/auth/register_page.dart';
import 'package:resumecraft/utils/interceptors/dio_request_interceptor.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';

Widget _defaultHome = const LoginPage(); // Default to LoginPage initially

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if the user is logged in
  bool result = await UserSharedPrefs.isLoggedIn();

  // Retrieve the token if available
  final prefs = await UserSharedPrefs.getLoginResponse();
  final token = prefs?.token ?? '';

  // Initialize Dio with the token if present
  if (token.isNotEmpty) {
    DioClient.initializeDio(token);
  }

  // Set default home to HomePage if the user is logged in
  if (result) {
    _defaultHome = const HomePage();
  }

  // Pass the _defaultHome widget to MyApp
  runApp(MyApp(defaultHome: _defaultHome));
}

class MyApp extends StatelessWidget {
  final Widget defaultHome;

  const MyApp({super.key, required this.defaultHome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RESUMECRAFT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        // ================= default ===================
        '/': (context) => defaultHome,

        // ================= auth ===================
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),

        // ================= home ===================
        '/home': (context) => const HomePage(),

        // ================= profiles ===================
        '/profiles': (context) => const ProfilePage(),

        // ================= profile-sections ===================
        '/profile-section': (context) => const ProfileSection(),

        // ================= create-section-detail ===================
        '/create-personal-detail': (context) => const PersonalDetail(),
      },
    );
  }
}
