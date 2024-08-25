import 'package:flutter/material.dart';

import 'package:resumecraft/services/objective_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/objective/read/objectives_model.dart';

mixin ObjectivesMixin<T extends StatefulWidget> on State<T> {
  List<Objectives> objectives = [];

  @override
  void initState() {
    super.initState();
    _loadObjectives();
  }

  Future<void> _loadObjectives() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await ObjectiveAPIService.getObjectives(token);
        final objs = ObjectivesModel.fromJson(data);
        setState(() {
          objectives = objs.objectives ?? [];
        });
      } catch (e) {
        print('Failed to set objectives: $e');
      }
    }
  }
}
