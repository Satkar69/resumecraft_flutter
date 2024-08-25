import 'package:flutter/material.dart';
import 'package:resumecraft/services/objective_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/objective/read/objective_model.dart';

mixin ObjectiveMixin<T extends StatefulWidget> on State<T> {
  Objective? objective;
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
    _loadObjective();
  }

  Future<void> _loadObjective() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailID != null) {
      try {
        final data = await ObjectiveAPIService.getObjectiveByPersonalDetail(
            token, personalDetailID!);
        if (data != null) {
          final obj = ObjectiveModel.fromJson(data);
          if (mounted) {
            setState(() {
              objective = obj.objective ?? Objective();
              _detailsLoaded = true;
            });
          }
        }
      } catch (e) {
        print('Failed to set objective: $e');
      }
    }
  }
}
