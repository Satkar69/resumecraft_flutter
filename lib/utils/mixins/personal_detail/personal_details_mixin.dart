import 'package:flutter/material.dart';
import 'package:resumecraft/api_services/personal_detail_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/personal_detail/read/personal_details_model.dart';

mixin PersonalDetailsMixin<T extends StatefulWidget> on State<T> {
  List<Userdetails> personalDetails = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadPersonalDetails();
  }

  Future<void> loadPersonalDetails() async {
    if (_isLoading) return;

    _isLoading = true;
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await PersonalDetailAPIService.getPersonalDetails(token);
        final details = PersonalDetailsModel.fromJson(data);
        if (mounted) {
          setState(() {
            personalDetails = details.userdetails ?? [];
            _isLoading = false;
          });
        }
      } catch (e) {
        print('Failed to set personal details: $e');
        _isLoading = false;
      }
    } else {
      _isLoading = false;
    }
  }
}
