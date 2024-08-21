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
              '/create-personal-detail'),
          _buildSectionTile(context, Icons.school, 'Education'),
          _buildSectionTile(context, Icons.work, 'Experience'),
          _buildSectionTile(context, Icons.star, 'Skills'),
          _buildSectionTile(context, Icons.flag, 'Objective'),
          _buildSectionTile(context, Icons.build, 'Projects'),
          // const Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text(
          //     'More Sections',
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // _buildSectionTile(context, Icons.email, 'Cover Letter'),
          // _buildSectionTile(context, Icons.add, 'Add More Section'),
          // const Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text(
          //     'Manage Sections',
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
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

  ListTile _buildSectionTile(BuildContext context, IconData icon, String title,
      [String? route]) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
