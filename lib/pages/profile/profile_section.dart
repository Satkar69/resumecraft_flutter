import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final Color primaryColor = HexColor('#283B71');

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = args?['personalDetailID'] as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Sections',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSectionTile(context, Icons.person, 'Personal Details',
              '/personal-detail', id),
          _buildSectionTile(
              context, Icons.school, 'Education', '/education', id),
          _buildSectionTile(
              context, Icons.work, 'Experience', '/experience', id),
          _buildSectionTile(context, Icons.star, 'Skills', '/skill', id),
          _buildSectionTile(context, Icons.flag, 'Objective', '/objective', id),
          _buildSectionTile(context, Icons.build, 'Projects', '/project', id),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        color: primaryColor,
        child: GestureDetector(
          onTap: () {
            // Handle View CV action
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.remove_red_eye, color: Colors.white),
                SizedBox(width: 8.0),
                Text(
                  'View CV',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile _buildSectionTile(
    BuildContext context,
    IconData icon,
    String title, [
    String? route,
    String? personalDetailID,
  ]) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (route != null) {
          Navigator.of(context).pop();
          Navigator.pushNamed(
            context,
            route,
            arguments: personalDetailID != null
                ? {'personalDetailID': personalDetailID}
                : null,
          );
        }
      },
    );
  }
}
