import 'package:flutter/material.dart';
import 'package:resumecraft/services/education_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/education/read/education_model.dart';

mixin EducationMixin<T extends StatefulWidget> on State<T> {
  Education? education;
  String? personalDetailId;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Optionally, you might not call _loadEducation here if id is not set
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
    }
    if (personalDetailId != null) {}
    _loadEducation();
  }

  Future<void> _loadEducation() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailId != null) {
      try {
        final data =
            await EducationAPIService.getEducation(token, personalDetailId!);
        if (data != null) {
          final edu = EducationModel.fromJson(data);
          if (mounted) {
            setState(() {
              education = edu.education ?? Education();
              _detailsLoaded = true;
            });
          }
        }
      } catch (e) {
        print('Failed to set education: $e');
      }
    }
  }
}
