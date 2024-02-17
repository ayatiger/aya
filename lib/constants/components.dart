// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'colors.dart';


double screenWidth(BuildContext context, double value) {
  return MediaQuery.of(context).size.width * value;
}

double screenHeight(BuildContext context, double value) {
  return MediaQuery.of(context).size.height * value;
}

double padding(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.04;
}

TextStyle minTextStyle(BuildContext context, {color}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color ?? const Color.fromRGBO(136, 133, 133, 1),
    // overflow: TextOverflow.ellipsis,
  );
}

TextStyle mainTextStyle(BuildContext context, {color}) {
  return TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: color ?? Colors.black,
    // overflow: TextOverflow.ellipsis,
  );
}

TextStyle midTextStyle(BuildContext context, color) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
    // overflow: TextOverflow.ellipsis,
  );
}

void showProgressDialog(BuildContext context, {Color? color}) {
  AlertDialog progressAlertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? defaultColor),
      ),
    ),
  );
  showDialog(
    barrierColor: white.withOpacity(0),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Container(
        height: 100,
        width: 100,
        child: Center(
          child: progressAlertDialog,
        ),
      );
    },
  );
}

Row buildDiscoverArrow(
  Size size,
  String discoverName,
) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(size.width * .2),
            bottomRight: Radius.circular(size.width * .2),
          ),
        ),
        height: size.height * .01,
        width: size.width * .1,
      ),
      SizedBox(width: size.width * .015),
      Text(
        discoverName,
        style: TextStyle(
          fontSize: size.width * .06,
          fontWeight: FontWeight.bold,
          color: defaultColor,
        ),
      ),
    ],
  );
}

ShaderMask iconSh(icon, {double? size}) => ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => const LinearGradient(
        colors: <Color>[
          Color.fromRGBO(60, 31, 168, 1),
          Color.fromRGBO(212, 206, 238, 1.0),
        ],
      ).createShader(bounds),
      child: Icon(
        icon,
        size: size,
      ),
    );

buildSnackBar(String? message, context, duration) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message!,
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

void navigateTo(Widget, context) => Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: Widget,
          );
        },
      ),
    );

void navigateAndFinish(Widget, context) => Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: Widget,
          );
        },
      ),
      (route) => false,
    );

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

TextFormField TFF({
  validator,
  required action,
  required TextInputType? type,
  required bool isPrefix,
  required bool underlineBorder,
  String? label,
  dynamic controller,
  IconData? prefix,
  IconData? suffix,
  bool secure = false,
  suffixPressed,
  prefixPressed,
  Function? onSubmit,
  String? hint,
  Color? hintColor,
  Color? SuffixContainerColor,
  Color? labelColor,
  bool readOnly = false,
  VoidCallback? fun,
  VoidCallback? onEditingComplete,
  Color? bc,
  bool? filled,
  Color? filledColor,
  Color? borderColor,
  Color? prefixColor,
  Color? suffixColor,
  Color? outLineBorderColor,
  Color? textColor,
  int? maxLines,
  double? suffixSize,
  double? borderRadius,
  double? prefixIconSize,
  bool isOutLineBorder = false,
  bool isEnabledBorder = false,
  ValueChanged<String>? onChanged,
}) =>
    TextFormField(
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      style: TextStyle(color: textColor ?? defaultColor),
      maxLines: maxLines,
      onTap: fun,
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      textInputAction: action,
      keyboardType: type,
      obscureText: secure,
      decoration: InputDecoration(
        focusedBorder: isOutLineBorder
            ? OutlineInputBorder(
                borderSide:
                    BorderSide(color: outLineBorderColor ?? defaultColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 20),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: defaultColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 20),
              ),
        errorBorder: underlineBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(borderRadius ?? 20),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(borderRadius ?? 20),
              ),
        enabledBorder: underlineBorder
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 20),
                borderSide: BorderSide(color: borderColor!),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 20),
                borderSide: BorderSide(color: borderColor!),
              ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          borderSide: isEnabledBorder
              ? BorderSide(color: Color.fromRGBO(217, 217, 217, 1))
              : BorderSide(color: white),
        ),
        prefixIcon: isPrefix
            ? IconButton(
                icon: Icon(
                  prefix,
                  color: prefixColor ?? defaultColor,
                  size: prefixIconSize ?? 25,
                ),
                onPressed: () {
                  prefixPressed();
                },
              )
            : null,
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor ?? Color.fromRGBO(126, 126, 126, 1),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        filled: filled,
        fillColor: filledColor ?? Colors.white,
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          color: labelColor ?? defaultColor,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: TextStyle(
          fontSize: 20,
          color: labelColor ?? defaultColor,
          fontWeight: FontWeight.bold,
        ),
        suffixIcon: Padding(
          padding: SuffixContainerColor != null
              ? EdgeInsets.all(8.0)
              : EdgeInsets.all(0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SuffixContainerColor ?? Colors.transparent,
            ),
            child: IconButton(
              icon: Icon(
                suffix,
                size: suffixSize ?? 25,
                color: suffixColor ?? defaultColor,
              ),
              onPressed: () {
                suffixPressed();
              },
            ),
          ),
        ),

      ),
    );
