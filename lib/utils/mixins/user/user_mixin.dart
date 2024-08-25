import 'package:flutter/material.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile/profile_model.dart';
import 'package:resumecraft/api_services/user_api_service.dart';

mixin UserProfileMixin<T extends StatefulWidget> on State<T> {
  String userToken = '';
  String userId = '';
  String username = '';
  String userEmail = '';
  String createdAt = '';
  String updatedAt = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await UserAPIService.getUserProfile(token);
        final profile = ProfileModel.fromJson(data);
        setState(() {
          userToken = prefs?.token ?? '';
          userId = profile.user?.id ?? 'Id';
          username = profile.user?.username ?? 'User';
          userEmail = profile.user?.email ?? 'Email';
          createdAt = profile.user?.createdAt ?? 'CreatedAt';
          updatedAt = profile.user?.updatedAt ?? 'UpdatedAt';
        });
      } catch (e) {
        print('Failed to set user profile: $e');
      }
    }
  }
}
