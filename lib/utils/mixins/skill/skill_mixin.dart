import 'package:flutter/material.dart';
import 'package:resumecraft/services/skill_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/skills/read/skill_model.dart';

mixin SkillMixin<T extends StatefulWidget> on State<T> {
  Skill? skill;
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
    _loadSkill();
  }

  Future<void> _loadSkill() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailId != null) {
      try {
        final data = await SkillAPIService.getSkill(token, personalDetailId!);
        if (data != null) {
          final sk = SkillModel.fromJson(data);
          if (mounted) {
            setState(() {
              skill = sk.skill ?? Skill();
              _detailsLoaded = true;
            });
          }
        }
      } catch (e) {
        print('Failed to set skill: $e');
      }
    }
  }
}
