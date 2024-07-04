import 'package:flutter/services.dart';
import 'package:machine_test/components/textfield_validation.dart';
import '../core_utils/export_dependency.dart';

class FormFieldWithPrefixIcon extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? image;
  final String? focusNodeText;
  final String? validationMessage;
  final Color? color;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool obscureValue;
  final bool passwordFilled;
  final bool isEmail;
  final bool isUserName;
  final bool isNumber;
  final bool isUniqueCode;
  final bool? autoValidate;
  final bool? isLabel;
  final bool needValidation;
  final bool isEmailValidator;
  final bool isInstagramURLValidator;
  final bool isFacebookURLValidator;
  final bool isTiktokURLValidator;
  final bool prefixIcon;
  final bool readOnly;
  final bool isDouble;
  final int? maxLength;
  final String? validation;
  final int? maxLines;
  final int? minCredits;
  final VoidCallback? callBackFunction;
  final Function(String)? onFieldSubmitted;
  final Function()? onComplete;
  final Function()? onTap;
  final Function(String)? onChanged;
  FormFieldWithPrefixIcon(
      {Key? key,
        this.controller,
        this.validation,
        this.color,
        this.hintText,
        this.onTap,
        this.onComplete,
        this.isLabel,
        this.image,
        this.focusNodeText=null,
        this.autoValidate,
        this.minCredits,
        this.keyboardType,
        this.obscureValue = false,
        this.needValidation = false,
        this.isFacebookURLValidator = false,
        this.isTiktokURLValidator = false,
        this.isInstagramURLValidator = false,
        this.isEmailValidator = false,
        this.prefixIcon = false,
        this.passwordFilled = false,
        this.obscureText = false,
        this.isEmail = false,
        this.isDouble = false,
        this.isUserName = false,
        this.isNumber = false,
        this.isUniqueCode = false,
        this.callBackFunction,
        this.textInputAction,
        this.maxLength = 50,
        this.maxLines = 1,
        this.focusNode ,
        this.validationMessage,
        this.label,
        this.fillColor,
        this.onFieldSubmitted,
        this.onChanged,
        this.readOnly = false})
      : super(key: key);

  @override
  State<FormFieldWithPrefixIcon> createState() => _FormFieldWithPrefixIconState();
}

class _FormFieldWithPrefixIconState extends State<FormFieldWithPrefixIcon> {
  FocusNode focus=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: focus,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText, onTap: widget.onTap,canRequestFocus: true,
          // enableInteractiveSelection: false,
          maxLines: widget.maxLines,
          onEditingComplete: widget.onComplete,
          validator: widget.isEmail
              ? (value) => widget.validation
              : widget.needValidation
              ? (value) => TextFieldValidation.validation(
              value: value,
              isFacebookURLValidator: widget.isFacebookURLValidator,
              isInstagramURLValidator: widget.isInstagramURLValidator,
              isTiktokURLValidator: widget.isTiktokURLValidator,
              isEmailValidator: widget.isEmailValidator,
              message: widget.validationMessage)
              : null,
          inputFormatters: [
            NoInitialSpaceInputFormatter(),
            if (widget.isDouble)
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}%?$')),
            LengthLimitingTextInputFormatter(widget.maxLength),
            if (widget.isUserName) FilteringTextInputFormatter.deny(" "),
            if (widget.isEmail)
              FilteringTextInputFormatter.deny(
                RegExp(
                    r"\^|-|,|~| |`|#|\$|%|&|\*|_|:|;|\+|\(|\)|\{|\}|\[|\]|=|!|<|>|/|'|"),
              ),
            if (widget.isUniqueCode) UpperCaseTextFormatter(),
            if (widget.isUniqueCode) FilteringTextInputFormatter.deny(RegExp(r'\s')),
            // if(isUniqueCode)
            //   FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
            if (widget.isNumber) FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            if (widget.isLabel == true)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          textInputAction: widget.textInputAction,

          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(
              maxHeight: AppDimens.height35,
              minHeight: AppDimens.height35,
              minWidth: AppDimens.width35,
            ),floatingLabelBehavior:FloatingLabelBehavior.always  ,
            filled: true,helperMaxLines: 3,
            helperText: focus.hasPrimaryFocus?widget.focusNodeText:null,
            fillColor: widget.fillColor ?? AppColors.whiteColor,
            label: Text(widget.label!, style: AppTextStyle.euclidMedium(AppDimens.fontSize16,AppColors.color000000)),
     hintText:widget.hintText! ,
            hintStyle:AppTextStyle.euclidRegular(AppDimens.fontSize16, AppColors.color949BA5) ,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.color262626,
              ),
            ),
            contentPadding: EdgeInsets.only(
                left: AppDimens.width10,
                top: AppDimens.height10,
                bottom: AppDimens.height10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.color262626,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.redColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.redColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: AppColors.color262626,
              ),
            ),
            focusColor: AppColors.primaryColor,
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

class NoInitialSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Prevent entering a space as the initial character
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    return newValue;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
