import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_test/network/local_store/shared_preference.dart';

import '../../../../components/custom_loader.dart';
import '../../../../core_utils/flush_bar_message.dart';
import '../../../../core_utils/toasts.dart';
import '../../../../logger/app_logger.dart';
import '../../../../network/NetworkUrls/app_network_urls.dart';
import '../../../../network/models/request/auth/register_user.dart';
import '../../../../network/models/response/user/register_user_response.dart';
import '../../../../network/models/response/user/user_profile_update_response.dart';
import '../../../../network/repositories/auth_repository.dart';
import '../../../../routes/route_name.dart';

class UserRegistrationProvider extends ChangeNotifier{
  XFile? userImage;
  setUserImage(XFile? value) {
    userImage = value;
    notifyListeners();
  }


  Future<void> registerUserApi({
    required String firstName,
    required String lastName,
    required String countryCode,
    required String phoneNo,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);

        // Create request body data
        RegistrationRequest data = RegistrationRequest(
          firstName: firstName,
          lastName: lastName,
          countryCode: countryCode,
          phoneNo: phoneNo,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        );

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .authRegisterApi(data: data, url: AppNetworkUrls.userRegisterEndPint)
            .then((value) {
          final profileUpdateResponse =RegisterUserResponse.fromJson(value);
          logD("UILoginHit: $profileUpdateResponse");
          if (profileUpdateResponse.status == false) {
            Navigator.pop(context);
            FlushBarMessage.flushBarBottomErrorMessage(
                message: profileUpdateResponse.message!, context: context);
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              PreferenceUtils.setAccessToken(profileUpdateResponse.data!.token!);
              Toasts.getSuccessToast(text: profileUpdateResponse.message);
            updateImageApi(image: userImage, email: profileUpdateResponse.data!.email, context: context);
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



  Future<void> updateImageApi(
      {required XFile? image,required email,
        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);



        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .completeProfileApi(image: image, url: AppNetworkUrls.profileUpdateEndPint)
            .then((value) {
          final loginResponse = ProfileUpdateResponse.fromJson(value);
          logD("UILoginHit: $loginResponse");
          if (loginResponse.status == false) {

            Navigator.pop(context);
            FlushBarMessage.flushBarBottomErrorMessage(
                message: loginResponse.message!, context: context);

          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Toasts.getSuccessToast(text: loginResponse.message);
              Navigator.pushNamedAndRemoveUntil(context,
                  RouteName.loginScreen, (route) => false);

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