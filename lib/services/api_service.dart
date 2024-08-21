import 'package:dio/dio.dart';

//====================== api-endpoints ===========================>
import 'package:resumecraft/config.dart';

//====================== auth ===========================>
import 'package:resumecraft/models/login/login_request_model.dart';
import 'package:resumecraft/models/login/login_response_model.dart';
import 'package:resumecraft/models/register/register_request_model.dart';
import 'package:resumecraft/models/register/register_response_model.dart';

//====================== profile-sections ===========================>
import 'package:resumecraft/models/profile_section/personal_detail/personal_detail_request_model.dart';
import 'package:resumecraft/models/profile_section/personal_detail/personal_detail_response_model.dart';

class APIService {
  static final Dio _dio = Dio();

//====================== auth ===========================>

  static Future<LoginResponseModel> login(
      LoginRequestModel requestModel) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.login}',
        data: requestModel.toJson(),
      );
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}${Config.register}',
        data: requestModel.toJson(),
      );
      return RegisterResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  static Future<dynamic> getUserProfile(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.userProfile}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

//====================== auth ===========================>

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

  static Future<dynamic> getPersonalDetail(String token) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}${Config.getPersonalDetail}',
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
