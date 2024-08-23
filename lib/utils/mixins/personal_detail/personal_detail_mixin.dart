import 'package:flutter/material.dart';
import 'package:resumecraft/services/personal_detail_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/personal_detail/read/personal_detail_model.dart';

mixin PersonalDetailMixin<T extends StatefulWidget> on State<T> {
  Userdetail? personalDetail;
  String? personalDetailId;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Optionally, you might not call _loadPersonalDetails here if id is not set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final id = args?['personalDetailId'] as String?;
      if (id != null && !_detailsLoaded) {
        setPersonalDetailId(id);
      }
    });
  }

  // Method to set the personalDetailId and load details
  void setPersonalDetailId(String? id) {
    if (personalDetailId != id) {
      personalDetailId = id;
      _loadPersonalDetails();
    }
  }

  Future<void> _loadPersonalDetails() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailId != null) {
      try {
        final data = await PersonalDetailAPIService.getPersonalDetail(
            token, personalDetailId!);
        final detail = PersonalDetailModel.fromJson(data);
        if (mounted) {
          setState(() {
            personalDetail = detail.userdetail ?? Userdetail();
            _detailsLoaded = true;
          });
        }
      } catch (e) {
        print('Failed to set personal detail: $e');
      }
    }
  }
}
