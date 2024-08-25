import 'package:flutter/material.dart';
import 'package:resumecraft/services/experience_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/experience/read/experience_model.dart';

mixin ExperienceMixin<T extends StatefulWidget> on State<T> {
  Experience? experience;
  String? personalDetailID;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Optionally, you might not call _loadExperience here if id is not set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final id = args?['personalDetailID'] as String?;
      if (id != null && !_detailsLoaded) {
        setPersonalDetailId(id);
      }
    });
  }

  // Method to set the personalDetailID and load details
  void setPersonalDetailId(String? id) {
    if (personalDetailID != id) {
      personalDetailID = id;
    }
    if (personalDetailID != null) {}
    _loadExperience();
  }

  Future<void> _loadExperience() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailID != null) {
      try {
        final data =
            await ExperienceAPIService.getExperience(token, personalDetailID!);
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
