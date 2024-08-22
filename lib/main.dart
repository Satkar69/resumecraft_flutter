import 'package:flutter/material.dart';

import 'package:resumecraft/pages/profile/profile_section.dart';
import 'package:resumecraft/pages/auth/login_page.dart';
import 'package:resumecraft/pages/home/home_page.dart';
import 'package:resumecraft/pages/profile_section/personal_detail.dart';
import 'package:resumecraft/pages/profile/profile_page.dart';
import 'package:resumecraft/pages/auth/register_page.dart';
import 'package:resumecraft/utils/interceptors/dio_request_interceptor.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool result = await UserSharedPrefs.isLoggedIn();
  final prefs = await UserSharedPrefs.getLoginResponse();
  final token = prefs?.token ?? '';
  if (token.isNotEmpty) {
    DioClient.initializeDio(
        token); // initialize dio interceptor with token for authenticated requests
  }
  if (result) {
    _defaultHome = const HomePage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        // ================= default ===================
        '/': (context) => _defaultHome,

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
