import 'package:flutter/material.dart';

import 'package:resumecraft/services/project_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/projects/read/projects_model.dart';

mixin ProjectsMixin<T extends StatefulWidget> on State<T> {
  List<Projects> projects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await ProjectAPIService.getProjects(token);
        final projs = ProjectsModel.fromJson(data);
        setState(() {
          projects = projs.projects ?? [];
        });
      } catch (e) {
        print('Failed to set projects: $e');
      }
    }
  }
}
