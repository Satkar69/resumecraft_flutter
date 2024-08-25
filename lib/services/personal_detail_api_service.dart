import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/personal_detail/write/personal_detail_request_model.dart';
import 'package:resumecraft/models/profile_section/personal_detail/write/personal_detail_response_model.dart';
import 'package:resumecraft/models/delete/delete_model.dart';

class PersonalDetailAPIService {
  static final Dio _dio = Dio();

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
      throw Exception('Failed to get all personal details: $e');
    }
  }

  static Future<dynamic> getPersonalDetail(
      String token, String personalDetailID) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.personalDetailByID}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get the selected personal detail: $e');
    }
  }

  static Future<PersonalDetailResponseModel> updatePersonalDetail(
      PersonalDetailRequestModel requestModel,
      String token,
      personalDetailID) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}${Config.personalDetailByID}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );
      return PersonalDetailResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user personal detail: $e');
    }
  }

  static Future<DeleteModel> deletePersonalDetail(
      DeleteModel requestModel, String token, personalDetailID) async {
    try {
      final response = await _dio.delete(
        '${Config.apiUrl}${Config.personalDetailByID}$personalDetailID',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: requestModel.toJson(),
      );

      return DeleteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to delete user personal detail: $e');
    }
  }
}
