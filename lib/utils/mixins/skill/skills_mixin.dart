import 'package:flutter/material.dart';

import 'package:resumecraft/services/skill_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/skills/read/skills_model.dart';

mixin SkillsMixin<T extends StatefulWidget> on State<T> {
  List<Skills> skills = [];

  @override
  void initState() {
    super.initState();
    _loadSkills();
  }

  Future<void> _loadSkills() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await SkillAPIService.getSkills(token);
        final sks = SkillsModel.fromJson(data);
        setState(() {
          skills = sks.skills ?? [];
        });
      } catch (e) {
        print('Failed to set skills: $e');
      }
    }
  }
}
