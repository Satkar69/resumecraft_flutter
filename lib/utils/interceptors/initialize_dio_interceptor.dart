import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/utils/interceptors/dio_request_interceptor.dart';

class DioUtils {
  static Future<void> initialize() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';

    if (token.isNotEmpty) {
      DioClient.initializeDio(token);
    }
  }
}
