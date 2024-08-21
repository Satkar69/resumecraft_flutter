import 'package:flutter/material.dart';

import 'package:resumecraft/pages/create_profile.dart';
import 'package:resumecraft/pages/login_page.dart';
import 'package:resumecraft/pages/home_page.dart';
import 'package:resumecraft/pages/create_personal_detail.dart';
import 'package:resumecraft/pages/profile_page.dart';
import 'package:resumecraft/pages/register_page.dart';
import 'package:resumecraft/services/shared_service.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
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
        '/': (context) => _defaultHome,
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(),
        '/profiles': (context) => const ProfilePage(),
        '/create-profile': (context) => const CreateProfile(),
        '/create-personal-detail': (context) => const CreatePersonalDetail(),
      },
    );
  }
}
