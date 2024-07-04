import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_test/components/background_widget.dart';
import 'package:machine_test/components/common_button.dart';
import 'package:machine_test/components/custom_text_field.dart';
import 'package:machine_test/core_utils/app_colors.dart';
import 'package:machine_test/core_utils/app_style.dart';
import 'package:machine_test/modules/auth/user_register/provider/user_registration_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core_utils/app_dimens.dart';
import '../../../../core_utils/flush_bar_message.dart';
import '../../../../core_utils/local_strings.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _countryCodeController.dispose();
    _phoneNoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<UserRegistrationProvider>(builder: (context, provider, child) {
      return backgroundImg(child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){ Navigator.pop(context);}, icon:const Icon(Icons.keyboard_backspace)),
                      Text(
                        "Sign Up",
                        style: TextStyle(decoration: TextDecoration.underline,color: AppColors.color000000,fontWeight: FontWeight.w500,fontSize: AppDimens.fontSize16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            XFile? image = await pickImage(context: context);
                            provider.setUserImage(image!);
                          },
                          splashFactory: NoSplash.splashFactory,
                          child: showImage(provider.userImage)),
                    ],
                  ),
                  SizedBox(height: AppDimens.height40,),
                  FormFieldWithPrefixIcon(
                    controller: _firstNameController,
                    label: 'First Name',
                    hintText: 'Enter your first name',
                    needValidation: true,
                    validationMessage: 'Please enter your first name',
                    isUserName: true,
                  ),
                  const SizedBox(height: 16),
                  FormFieldWithPrefixIcon(
                    controller: _lastNameController,
                    label: 'Last Name',
                    hintText: 'Enter your last name',
                    needValidation: true,
                    validationMessage: 'Please enter your last name',
                    isUserName: true,
                  ),
                  const SizedBox(height: 16),
                  FormFieldWithPrefixIcon(
                    controller: _countryCodeController,
                    label: 'Country Code',
                    hintText: 'Enter your country code',
                    needValidation: true,
                    validationMessage: 'Please enter your country code',
                    isNumber: true,
                  ),
                  const SizedBox(height: 16),
                  FormFieldWithPrefixIcon(
                    controller: _phoneNoController,
                    label: 'Phone Number',
                    hintText: 'Enter your phone number',
                    needValidation: true,
                    validationMessage: 'Please enter your phone number',
                    isNumber: true,
                  ),
                  const SizedBox(height: 16),
                  FormFieldWithPrefixIcon(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    needValidation: true,
                    validationMessage: 'Please enter a valid email',
                    isEmailValidator: true,

                  ),
                  const SizedBox(height: 16),
                  FormFieldWithPrefixIcon(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Enter your password',
                    needValidation: true,
                    validationMessage: 'Please enter your password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  FormFieldWithPrefixIcon(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Confirm your password',
                    needValidation: true,
                    validationMessage: 'Please enter confirm password',
                    obscureText: true,
              
                  ),
                  SizedBox(height: AppDimens.height40),

              
                  CommonButton(
                      title: "Update",
                      onTap: () {
                        if (provider.userImage == null) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: "Please select image first", context: context);
                        } else if(_passwordController.text!=_confirmPasswordController.text) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: "Password and confirm password does not matched !", context: context);
                        }else if (_formKey.currentState!.validate()) {
                          provider.registerUserApi(firstName: _firstNameController.text, lastName: _lastNameController.text, countryCode: _countryCodeController.text, phoneNo: _phoneNoController.text, email: _emailController.text, password: _passwordController.text, confirmPassword: _confirmPasswordController.text, context: context);
                        }

                      })
                ],
              ),
            ),
          ),
        ),
      ), context: context);

    }));
  }


  showImage(XFile? file) {
    if (file != null) {
      return Container(
          height: AppDimens.height100,
          width: AppDimens.width100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radius50),
            image: DecorationImage(
                fit: BoxFit.fill, image: FileImage(File(file.path))),
          ),);
    }

    return Container(
        height: AppDimens.height150,
        width: AppDimens.width150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius50),
          // image: const DecorationImage(
          // fit: BoxFit.fill, image: AssetImage(AppImage.dummyUser)),
        ),child: Icon(Icons.image,color: AppColors.color000000,size: AppDimens.height80,));
  }
  Future<XFile?> pickImage({@required BuildContext? context}) async {
    int? type;
    return showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(AppDimens.width15),
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.width10,
                right: AppDimens.width10,
                bottom: AppDimens.width10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      LocalStrings.selectImageSource,
                      style: AppTextStyle.euclidRegular(
                          AppDimens.fontSize14, AppColors.color000000),
                    )),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.clear,
                          size: AppDimens.width20,
                          color: Colors.red,
                        ))
                  ],
                ),
                SizedBox(
                  height: AppDimens.height20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.green.withOpacity(0.2),
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimens.width15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.camera,
                            color: Colors.green,
                          ),
                          TextButton(
                            child: Text(
                              LocalStrings.camera,
                              style: AppTextStyle.euclidRegular(
                                  AppDimens.fontSize14, AppColors.color000000),
                            ),
                            onPressed: () async {
                              type = 1;
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.red.withOpacity(0.2),
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimens.width15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.landscape_rounded,
                            color: Colors.red,
                          ),
                          TextButton(
                            child: Text(
                              LocalStrings.gallery,
                              style: AppTextStyle.euclidRegular(
                                  AppDimens.fontSize14, AppColors.color000000),
                            ),
                            onPressed: () async {
                              type = 2;
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppDimens.height20,
                ),
              ],
            ),
          ),
        );
      },
    ).then((v) async {
      if (type != null) {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
            source: type == 1 ? ImageSource.camera : ImageSource.gallery);
        if (image != null) {
          return XFile(image.path);
        }
        return null;
      }
      return null;
    });
  }
}

