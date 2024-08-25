import 'package:flutter/material.dart';

import 'package:resumecraft/services/Experience_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/experience/read/experiences_model.dart';

mixin ExperiencesMixin<T extends StatefulWidget> on State<T> {
  List<Experiences> experiences = [];
  String? personalDetailID;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final personalDetailID = args?['personalDetailID'] as String?;
      if (personalDetailID != null && !_detailsLoaded) {
        setPersonalDetailID(personalDetailID);
      }
    });
  }

  void setPersonalDetailID(String? id) {
    if (personalDetailID != id) {
      personalDetailID = id;
      _loadExperiences();
    }
  }

  Future<void> _loadExperiences() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await ExperienceAPIService.getExperiencesByPersonalDetail(
            token, personalDetailID!);
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
