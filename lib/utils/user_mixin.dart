import 'package:flutter/material.dart';
import 'package:resumecraft/services/shared_service.dart';
import 'package:resumecraft/models/profile/profile_model.dart';
import 'package:resumecraft/services/api_service.dart';

mixin UserProfileMixin<T extends StatefulWidget> on State<T> {
  String id = '';
  String username = '';
  String email = '';
  String createdAt = '';
  String updatedAt = '';

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
        final profile = ProfileModel.fromJson(profileData);
        setState(() {
          id = profile.user?.id ?? 'Id';
          username = profile.user?.username ?? 'User';
          email = profile.user?.email ?? 'Email';
          createdAt = profile.user?.createdAt ?? 'CreatedAt';
          updatedAt = profile.user?.updatedAt ?? 'UpdatedAt';
        });
      } catch (e) {
        print('Failed to set user profile: $e');
      }
    }
  }
}
