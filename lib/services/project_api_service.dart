import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/projects/write/project_request_model.dart';
import 'package:resumecraft/models/profile_section/projects/write/project_response_model.dart';

class ProjectAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getProjectByPersonalDetail(
      String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.projectByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected project: $e');
    }
  }

  static Future<ProjectResponseModel> createProject(
      ProjectRequestModel requestModel, String token) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.createProject}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ProjectResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create project: $e');
    }
  }

  static Future<ProjectResponseModel> updateProjectByPersonalDetail(
      ProjectRequestModel requestModel, String token, personalDetailID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.projectByPersonalDetail}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return ProjectResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }
}
