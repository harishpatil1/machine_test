import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import '../../../../components/custom_loader.dart';
import '../../../../core_utils/flush_bar_message.dart';
import '../../../../core_utils/toasts.dart';
import '../../../../logger/app_logger.dart';
import '../../../../network/NetworkUrls/app_network_urls.dart';
import '../../../../network/local_store/shared_preference.dart';
import '../../../../network/models/request/auth/login_request.dart';
import '../../../../network/models/response/auth/login_response.dart';
import '../../../../network/repositories/auth_repository.dart';
import '../../../../routes/route_name.dart';

class LoginProvider extends ChangeNotifier
{

  Future<void> loginApi(
      {required String email,
       required String password,
        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        LoginRequest data = LoginRequest(
          email: email,
          password: password,
        );
        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .authLoginApi(data: data, url: AppNetworkUrls.loginEndPint)
            .then((value) {
          final loginResponse = LoginResponse.fromJson(value);
          logD("UILoginHit: $loginResponse");
          if (loginResponse.status == false) {

              Navigator.pop(context);
              FlushBarMessage.flushBarBottomErrorMessage(
                  message: loginResponse.message!, context: context);

          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {

              PreferenceUtils.setAccessToken(loginResponse.record!.authToken);

              Navigator.pop(context);
              Toasts.getSuccessToast(text: loginResponse.message);

                Navigator.pushNamedAndRemoveUntil(context, arguments:loginResponse.record ,
                    RouteName.homeScreen, (route) => false);

            });
          }
        }).onError((error, stackTrace) {
          Navigator.pop(context);
          FlushBarMessage.flushBarBottomErrorMessage(
              message: error.toString(), context: context);
        });
      } else {
        Toasts.getWarningToast(text: "No internet connection available");
      }
    });
  }
}