import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/services/shared_service.dart';
import 'package:resumecraft/models/profile/profile_model.dart';
import 'package:resumecraft/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color primaryColor = HexColor('#283B71');
  String username = '';
  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedService.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final profileData = await APIService.getUserProfile(token);
        // Assuming profileData is a Map<String, dynamic>, convert it to your ProfileModel
        final profile = ProfileModel.fromJson(profileData);
        setState(() {
          username = profile.user?.username ?? 'User';
        });
      } catch (e) {
        print('Failed to load user profile: $e');
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RESUMECRAFT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await SharedService.logout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, $username',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _profileUI(Icons.description, 'Profiles', '/profiles'),
                  SizedBox(width: 20),
                  _profileUI(Icons.download, 'Downloads', '/downloads'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileUI(IconData icon, String label, [String? route]) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
        // if (label == 'Profiles') {
        // } else if (label == 'Downloads') {
        //   Navigator.pushNamed(context, '/downloads');
        // }
        // You can add an else if here for 'Downloads' if needed
      },
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: primaryColor),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
