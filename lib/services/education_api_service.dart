import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/education/write/education_request_model.dart';
import 'package:resumecraft/models/profile_section/education/write/education_response_model.dart';

class EducationAPIService {
  static final Dio _dio = Dio();

  //====================== profile-sections (authenticated) ===========================>

  static Future<dynamic> getEducation(
      String token, String personalDetailId) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.educationByPersonalDetail}$personalDetailId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('get education triggered--------------------------------->');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected personal detail: $e');
    }
  }

  static Future<EducationResponseModel> writeEducation(
      EducationRequestModel requestModel,
      String token,
      personalDetailId) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.educationByPersonalDetail}$personalDetailId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return EducationResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user personal detail: $e');
    }
  }
}
