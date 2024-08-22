import 'package:dio/dio.dart';

//====================== dio request interceptor ===========================>
import 'package:resumecraft/utils/interceptors/dio_request_interceptor.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/personal_detail/personal_detail_request_model.dart';
import 'package:resumecraft/models/profile_section/personal_detail/personal_detail_response_model.dart';

class PersonalDetailAPIService {
  static final Dio _dio = DioClient.dio;

  //====================== profile-sections (authenticated) ===========================>

  static Future<PersonalDetailResponseModel> createPersonalDetail(
      PersonalDetailRequestModel requestModel, String token) async {
    try {
      final response =
          await _dio.post('${Config.apiUrl}${Config.createPersonalDetail}',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ),
              data: requestModel.toJson());
      return PersonalDetailResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user personal detail: $e');
    }
  }

  static Future<dynamic> getPersonalDetails(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.getPersonalDetails}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get user personal detail: $e');
    }
  }
}
