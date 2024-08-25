import 'package:flutter/material.dart';

import 'package:resumecraft/pages/profile/profile_section_page.dart';
import 'package:resumecraft/pages/auth/login_page.dart';
import 'package:resumecraft/pages/home/home_page.dart';
import 'package:resumecraft/pages/profile_section/education_page.dart';
import 'package:resumecraft/pages/profile_section/experience_page.dart';
import 'package:resumecraft/pages/profile_section/objective_page.dart';
import 'package:resumecraft/pages/profile_section/personal_detail_page.dart';
import 'package:resumecraft/pages/profile/profile_page.dart';
import 'package:resumecraft/pages/auth/register_page.dart';
import 'package:resumecraft/pages/profile_section/project_page.dart';
import 'package:resumecraft/pages/profile_section/skill_page.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';

Widget _defaultHome = const LoginPage(); // Default to LoginPage initially

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if the user is logged in
  bool result = await UserSharedPrefs.isLoggedIn();

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
      debugShowCheckedModeBanner: false,
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
        '/profile-section': (context) => const ProfileSectionPage(),

        // ================= create-section-detail ===================
        '/personal-detail': (context) => const PersonalDetailPage(),
        '/education': (context) => const EducationPage(),
        '/experience': (context) => const ExperiencePage(),
        '/skill': (context) => const SkillPage(),
        '/project': (context) => const ProjectPage(),
        '/objective': (context) => const ObjectivePage(),
      },
    );
  }
}
