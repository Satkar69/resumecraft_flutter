import 'package:flutter/material.dart';
import 'package:resumecraft/services/experience_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/experience/read/experience_model.dart';

mixin ExperienceMixin<T extends StatefulWidget> on State<T> {
  Experience? experience;
  String? personalDetailId;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Optionally, you might not call _loadExperience here if id is not set
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
    _loadExperience();
  }

  Future<void> _loadExperience() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailId != null) {
      try {
        final data =
            await ExperienceAPIService.getExperience(token, personalDetailId!);
        if (data != null) {
          final exp = ExperienceModel.fromJson(data);
          if (mounted) {
            setState(() {
              experience = exp.experience ?? Experience();
              _detailsLoaded = true;
            });
          }
        }
      } catch (e) {
        print('Failed to set experience: $e');
      }
    }
  }
}
