import 'package:flutter/gestures.dart';
import 'package:machine_test/components/common_button.dart';
import 'package:machine_test/core_utils/app_dimens.dart';
import 'package:provider/provider.dart';
import '../../../../components/background_widget.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../core_utils/export_dependency.dart';
import '../../../../core_utils/flush_bar_message.dart';
import '../../../../routes/route_name.dart';
import '../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  final String email;
  const LoginScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
@override
  void initState() {
 WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   emailController.text=widget.email;
 },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:backgroundImg(child:  SafeArea(
        bottom: false,
        child: Consumer<LoginProvider>(builder: (context, provider, child) {
          return Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppDimens.width30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Row(
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(decoration: TextDecoration.underline,color: AppColors.color000000,fontWeight: FontWeight.w500,fontSize: AppDimens.fontSize16),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimens.height30),
                      FormFieldWithPrefixIcon(
                        controller: emailController,
                        label:LocalStrings.email ,
                        hintText: LocalStrings.enterYourEmail,
                        focusNode: null,

                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                      FormFieldWithPrefixIcon(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        hintText: LocalStrings.enterYourPassword,
                        keyboardType: TextInputType.visiblePassword,
                        color: AppColors.primaryColor,
                        textInputAction: TextInputAction.done,
                        label: LocalStrings.password,
                      ),

                      SizedBox(
                        height: AppDimens.height5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                            },
                            child: Text(
                              LocalStrings.forgetPassword,
                              style:AppTextStyle.euclidRegular(AppDimens.fontSize16,AppColors.color212226),
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: AppDimens.height30,
                      ),
                      CommonButton(
                        title: LocalStrings.loginButtonText,
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          String email = emailController.text.trim();
                          var password = passwordController.text.trim();
                          if (_formKey.currentState!.validate()) {
                            if (email.isEmpty && password.isEmpty) {
                              FlushBarMessage.flushBarBottomErrorMessage(
                                  message: LocalStrings.pleaseEnterCredential,
                                  context: context);
                            } else if (email.isEmpty) {
                              FlushBarMessage.flushBarBottomErrorMessage(
                                  message:
                                  LocalStrings.pleaseEnterUserNameOrEmail,
                                  context: context);
                            } else if (password.isEmpty) {
                              FlushBarMessage.flushBarBottomErrorMessage(
                                  message: LocalStrings.pleaseEnterPassword,
                                  context: context);
                            } else {
                              provider.loginApi(
                                  email: email,
                                  password: password,
                                  context: context,
                              );
                            }
                          } else {}
                        },
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),

                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: LocalStrings.doNotHaveAnAccount,
                            style:AppTextStyle.euclidMedium(AppDimens.fontSize16, AppColors.color949BA5),
                            children: <TextSpan>[
                              TextSpan(
                                text: LocalStrings.signUp,
                                style:AppTextStyle.euclidMedium(AppDimens.fontSize16, AppColors.color0084FF),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, RouteName.userRegistrationScreen);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppDimens.height20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ), context: context,)

    );
  }
}
