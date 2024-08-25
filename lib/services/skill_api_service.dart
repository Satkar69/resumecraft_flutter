import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/skills/write/skill_request_model.dart';
import 'package:resumecraft/models/profile_section/skills/write/skill_response_model.dart';

class SkillAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getSkill(String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.skillByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected skill: $e');
    }
  }

  static Future<SkillResponseModel> createSkill(
      SkillRequestModel requestModel, String token) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.createSkill}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return SkillResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create skill: $e');
    }
  }

  static Future<SkillResponseModel> updateSkill(
      SkillRequestModel requestModel, String token, personalDetailID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.skillByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return SkillResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update skill: $e');
    }
  }
}
