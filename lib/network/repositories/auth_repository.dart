import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../core_utils/toasts.dart';
import '../../logger/app_logger.dart';
import '../local_store/shared_preference.dart';
import '../network_api_service.dart';

class AuthRepository {
  // Generate Instance
  static final AuthRepository _authRepository = AuthRepository();

  // Get Instance of the class.
  static AuthRepository get authRepositoryInstance => _authRepository;
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<dynamic> authLoginApi(
      {required dynamic data, required String url}) async {
    logD("authLoginApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authLoginApiError: $e");
    }
  }


  Future<dynamic> authRegisterApi(
      {required dynamic data, required String url}) async {
    logD("authRegisterApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authRegisterApiError: $e");
    }
  }

  Future<dynamic> completeProfileApi({
    XFile? image,
    required String url,
  }) async {
    try {
      var token = PreferenceUtils.getAccessToken() ?? "";
      Map<String, String> headerWithToken = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };

      MultipartFile? photo;
      if (image != null) {
        photo = await MultipartFile.fromFile(image.path, filename: image.name);
      }
      FormData formData =
          FormData.fromMap({"profile_img": photo});

      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(
              url: url, body: formData, myHeaders: headerWithToken);
      return response;
    } catch (e) {
      Toasts.getErrorToast(text: e.toString());
    }
  }
}
