// user_repository.dart
import 'package:dio/dio.dart';

import '../../logger/app_logger.dart';
import '../local_store/shared_preference.dart';
import '../network_api_service.dart';


class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  static UserRepository get userRepositoryInstance => _instance;
  final Dio _dio = Dio();

  UserRepository._internal();

  Future<dynamic> homePageApi({
    required String url,
  }) async {
    logD("authVerifyOTPApi url : $url");
    var token = PreferenceUtils.getAccessToken() ?? "";
    Map<String, String> headerWithToken = {'Authorization': 'Bearer $token'};

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callGetApiResponse(url: url, myHeaders: headerWithToken);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }
}
