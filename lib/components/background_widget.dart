import 'package:flutter/cupertino.dart';
import 'package:machine_test/core_utils/app_image.dart';

Widget backgroundImg({required Widget child,required BuildContext context}){
  return Stack(
    children: [
      Image.asset(AppImage.bgImage,height:MediaQuery.of(context).size.height,width:MediaQuery.of(context).size.width,fit: BoxFit.fill,),
      child
    ],
  );
}