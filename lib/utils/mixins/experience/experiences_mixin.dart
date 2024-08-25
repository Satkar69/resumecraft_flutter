import 'package:flutter/material.dart';

import 'package:resumecraft/services/Experience_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/experience/read/experiences_model.dart';

mixin ExperiencesMixin<T extends StatefulWidget> on State<T> {
  List<Experiences> experiences = [];

  @override
  void initState() {
    super.initState();
    _loadExperiences();
  }

  Future<void> _loadExperiences() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await ExperienceAPIService.getExperiences(token);
        final exps = ExperiencesModel.fromJson(data);
        setState(() {
          experiences = exps.experiences ?? [];
        });
      } catch (e) {
        print('Failed to set experiences: $e');
      }
    }
  }
}
