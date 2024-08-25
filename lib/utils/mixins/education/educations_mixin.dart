import 'package:flutter/material.dart';

import 'package:resumecraft/services/education_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/education/read/educations_model.dart';

mixin EducationsMixin<T extends StatefulWidget> on State<T> {
  List<Educations> educations = [];

  @override
  void initState() {
    super.initState();
    _loadEducations();
  }

  Future<void> _loadEducations() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await EducationAPIService.getEducations(token);
        final eds = EducationsModel.fromJson(data);
        setState(() {
          educations = eds.educations ?? [];
        });
      } catch (e) {
        print('Failed to set educations: $e');
      }
    }
  }
}
