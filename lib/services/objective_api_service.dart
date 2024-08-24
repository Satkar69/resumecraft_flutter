import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/objective/write/objective_request_model.dart';
import 'package:resumecraft/models/profile_section/objective/write/objective_response_model.dart';

class ObjectiveAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getObjective(
      String token, String personalDetailId) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.objectiveByPersonalDetail}$personalDetailId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected objective: $e');
    }
  }

  static Future<ObjectiveResponseModel> createObjective(
      ObjectiveRequestModel requestModel, String token) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.createObjective}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ObjectiveResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create objective: $e');
    }
  }

  static Future<ObjectiveResponseModel> updateObjective(
      ObjectiveRequestModel requestModel,
      String token,
      personalDetailId) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.objectiveByPersonalDetail}$personalDetailId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ObjectiveResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update objective: $e');
    }
  }
}
