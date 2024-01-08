// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:io';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:path_provider/path_provider.dart';
import 'package:report_issue/utils/colors.dart';

// widgets to change statusbarcolor
Widget annotedRegion(Widget givechild) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: givechild,
    );
Widget annotedRegionLightIcon(Widget givechild) =>
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xffFAFAFA),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: givechild,
    );

Widget verticalSpacing(double giveHeigh) => SizedBox(
      height: giveHeigh.sp,
    );

Widget horizontalSpacing(double giveWidth) => SizedBox(
      width: giveWidth.sp,
    );

Widget iconWidget(IconData giveIcon, Color? giveColor, double? giveSize) =>
    Icon(
      giveIcon,
      color: giveColor,
      size: giveSize,
    );

Widget backArrow(
        {double giveIconSize = 25, Color giveIconColor = Colors.black}) =>
    IconButton(
      onPressed: (() => Get.back()),
      icon: iconWidget(Icons.arrow_back_ios, giveIconColor, giveIconSize.sp),
    );

// text widget using google fonts
Widget text(
        {required String giveText,
        double fontsize = 15,
        FontWeight fontweight = FontWeight.normal,
        Color textColor = Colors.black,
        double? textHeight,
        String fontfamily = 'Poppins',
        TextDecoration? underline,
        double? letterSpacing,
        TextAlign textAlignment = TextAlign.start}) =>
    Text(giveText.tr,
        textAlign: textAlignment,
        style: textStyle(
            underline: underline,
            fontfamily: fontfamily,
            fontsize: fontsize,
            fontweight: fontweight,
            textColor: textColor,
            textHeight: textHeight));

TextStyle textStyle(
    {FontWeight? fontweight,
    Color? textColor,
    double? textHeight,
    String fontfamily = 'Open Sans',
    double? fontsize,
    TextDecoration? underline}) {
  return GoogleFonts.getFont(fontfamily,
      textStyle: TextStyle(
        decoration: underline,
        color: textColor,
        fontSize: fontsize!.sp,
        fontWeight: fontweight,
        height: textHeight,
      ));
}

Widget multiLinetextmethod(
    {required text,
    double fontsize = 1,
    FontWeight fontweight = FontWeight.normal,
    color = const Color(0xff29375F),
    TextAlign textAlign = TextAlign.center,
    double textHeight = 1,
    String fontFamily = 'Poppins',
    int maxLines = 2,
    double width = 200,
    AlignmentGeometry alignment = Alignment.centerLeft}) {
  return SizedBox(
    width: width.sp,
    child: Align(
      alignment: alignment,
      child: Text(
        text,
        style: GoogleFonts.getFont(
          (fontFamily),
          textStyle: TextStyle(
              // fontSize: ((Get.height * 0.01) * fontsize).toDouble(),
              fontSize: fontsize.sp,
              fontWeight: fontweight,
              height: textHeight,
              color: color),
        ),
        // style: TextStyle(
        //   fontSize:((Get.height *0.01) * fontsize).toDouble() ,
        //   fontWeight: fontweight,
        //   fontFamily: "Inter",
        //   color: color
        // ),
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    ),
  );
}

// Alignment widgets
Widget centerAlign(giveChild) => Align(
      alignment: Alignment.center,
      child: giveChild,
    );

Widget alignRight(giveChild) => Align(
      alignment: Alignment.centerRight,
      child: giveChild,
    );

Widget alignleft(giveChild) => Align(
      alignment: Alignment.centerLeft,
      child: giveChild,
    );

// formfield widgets
Widget textField(
        {required TextEditingController fieldController,
        String? giveHint,
        bool? unfocusOnTapOutside = true,
        bool? isExpand = false,
        bool? labelAlwaysOnTop = false,
        required void Function(String)? onFieldEntry,
        bool autofocus = false,
        String? hintText,
        double lableTextSize = 16,
        double hintTextSize = 16,
        Color labelColor = Colors.transparent,
        Color borderColor = Colors.transparent,
        double? giveHeight = 60,
        double? giveWidth,
        bool alignLabelasHint = false,
        Widget? suffixWidget,
        FontWeight? textWeight,
        BoxConstraints suffixConstraints = const BoxConstraints(
            minHeight: 0, minWidth: 0, maxHeight: 25, maxWidth: 30),
        EdgeInsetsGeometry contentPadding = const EdgeInsets.only(left: 5),
        Widget? prefixWidget,
        Text? giveLabel,
        FocusNode? fieldFocusNode,
        void Function()? onFieldTap,
        String? Function(String?)? validatorfun,
        int? fieldMaxLines = 1,
        bool isFieldReadOnly = false,
        Color textColor = Colors.black,
        double borderRadius = 12,
        TextInputType? keyboardType,
        double? cursorHeight,
        // double cursorWidth =3.0,
        Color? cursorColor,
        TextAlign textAlignment = TextAlign.start,
        Color backgroundColor = Colors.white,
        bool obscureText = false}) =>
    Container(
      height: giveHeight,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius)),
      width: giveWidth,
      child: TextFormField(
        cursorHeight: cursorHeight,
        // cursorWidth: cursorWidth,
        expands: isExpand!,
        keyboardType: keyboardType,
        cursorColor: AppTheme.textColor,
        textAlign: textAlignment,
        obscureText: obscureText,
        readOnly: isFieldReadOnly,
        textInputAction: TextInputAction.newline,
        maxLines: fieldMaxLines,
        onTap: onFieldTap,
        validator: validatorfun,
        focusNode: fieldFocusNode,
        autofocus: false,
        onChanged: onFieldEntry,
        controller: fieldController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: false,
          contentPadding: contentPadding,
          prefixIcon: prefixWidget,
          suffixIcon: suffixWidget,
          suffixIconConstraints: suffixConstraints,
          floatingLabelBehavior: labelAlwaysOnTop == true
              ? FloatingLabelBehavior.always
              : alignLabelasHint
                  ? FloatingLabelBehavior.never
                  : FloatingLabelBehavior.auto,

          alignLabelWithHint: alignLabelasHint,
          labelStyle:
              textStyle(textColor: labelColor, fontsize: lableTextSize.sp),

          labelText: giveHint?.tr,
          hintText: hintText?.tr,
          hintStyle:
              textStyle(textColor: labelColor, fontsize: hintTextSize.sp),

          // hintText: giveHint,
          // labelText: giveLabel.toString(),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: hintTextSize.sp,
          color: textColor,
          fontWeight: textWeight,
        ),
        onTapOutside: (event) {
          unfocusOnTapOutside == true
              ? FocusManager.instance.primaryFocus?.unfocus()
              : null;
        },
      ),
    );

//button widgets
Widget button(
        {required Color buttonColor,
        required onPress,
        required String buttonText,
        bool? isWidget,
        Widget? loader,
        double? buttonWidth,
        double buttonHeight = 30,
        double borderWidth = 0,
        double borderRadius = 4,
        Color borderColor = Colors.white,
        Color buttonTextColor = Colors.white,
        double textSize = 17,
        String fontfamily = 'Poppins',
        TextAlign textAlign = TextAlign.start,
        FontWeight textWieght = FontWeight.normal}) =>
    SizedBox(
      height: buttonHeight.sp,
      width: buttonWidth,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: Colors.transparent,
            backgroundColor: buttonColor,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  borderRadius,
                ),
                side: BorderSide(color: borderColor)),
          ),
          onPressed: onPress,
          child: isWidget == true
              ? loader
              : text(
                  textAlignment: textAlign,
                  giveText: buttonText.tr,
                  fontsize: textSize,
                  fontweight: textWieght,
                  fontfamily: fontfamily,
                  textColor: buttonTextColor)),
    );

Widget outlineButton({
  required Widget giveChild,
  required void Function()? buttonOnPress,
  double giveHeight = 35,
  double giveWidth = 200,
  double borderRadius = 7,
  Color backgroundColor = Colors.transparent,
  Color borderColor = Colors.white,
  double borderWidth = 1,
}) =>
    SizedBox(
      height: giveHeight,
      width: giveWidth,
      child: OutlinedButton(
        onPressed: buttonOnPress,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(width: borderWidth, color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: giveChild,
      ),
    );
// Widget shimmer(Widget widget) {
//   return Shimmer(
//       period: const Duration(milliseconds: 800),
//       gradient: const LinearGradient(
//         colors: [
//           Color(0xFFEBEBF4),
//           Color(0xFFF4F4F4),
//           Color(0xFFEBEBF4),
//         ],
//         stops: [
//           0.1,
//           0.3,
//           0.4,
//         ],
//         begin: Alignment(-1.0, -0.3),
//         end: Alignment(1.0, 0.3),
//         tileMode: TileMode.clamp,
//       ),
//       child: widget);
// }

//divider widgets
Widget verticalDividerWidget(giveColor, double giveThickness,
        {double giveHeight = 30}) =>
    SizedBox(
      height: giveHeight,
      child: VerticalDivider(
        thickness: giveThickness,
        color: giveColor,
      ),
    );

Widget horizontalDividerWidget(Color giveColor, double giveThickness,
        {double giveheight = 0, double giveWidth = 30}) =>
    SizedBox(
      width: giveWidth.sp,
      child: Divider(
        height: giveheight,
        thickness: giveThickness,
        color: giveColor,
      ),
    );

//rounded edged container widgets
/// function which returns desired radius to the containers borderadius
/// when the provided [side] is true
/// else will return '0' as a double value
double cornerRadius(bool side, double radius) {
  if (side == true) {
    return radius;
  } else {
    return 0;
  }
}

/// widget method of a rounded edged container
/// this method can be used to created rounded edged container on all the sides
/// or any one of the side
/// it can be done by changind [top] and [bottom] as true/false
/// the default boolean value is true for both the sides
/// and the default border color is transparent and it can be changed by providing
/// desired value to [giveBorderColor]
Widget customContainer(
    {Color giveColor = Colors.transparent,
    Color giveBorderColor = Colors.transparent,
    double giveBorderWidth = 0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? giveHeight,
    double? giveWidth,
    double topLeft = 12,
    double topRight = 12,
    double bottomRight = 12,
    double bottomLeft = 12,
    bool shadow = false,
    bool top = true,
    bool bottom = true,
    Gradient? gradient,
    required Widget? containerChild}) {
  return Container(
    height: giveHeight,
    width: giveWidth,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
        color: giveColor,
        gradient: gradient,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 3),
              color: shadow
                  ? AppTheme.textColor.withOpacity(0.1)
                  : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 3)
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              cornerRadius(top, topLeft),
            ),
            topRight: Radius.circular(
              cornerRadius(top, topRight),
            ),
            bottomLeft: Radius.circular(
              cornerRadius(bottom, bottomLeft),
            ),
            bottomRight: Radius.circular(
              cornerRadius(bottom, bottomRight),
            )),
        border: Border.all(width: giveBorderWidth, color: giveBorderColor)),
    child: containerChild,
  );
}

/// Image.network child as a widget [giveUrl] as a String
networkImageMethod({
  required String assetName,
  double height = 30,
  double width = 30,
  BoxFit fit = BoxFit.contain,
  bool useOldImageOnUrlChange = false,
  Widget widget = const Text("No Default Image"),
}) {
  try {
    return CachedNetworkImage(
      imageUrl: assetName,
      height: height,
      width: width,
      fit: fit,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
    );
  } catch (e) {
    return widget;
  }
}

// Widget calendarButton() {
//   return Align(
//     alignment: Alignment.centerRight,
//     child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//       text(
//           giveText: "October",
//           textColor: AppTheme.yellowButton,
//           fontweight: FontWeight.w500,
//           fontsize: 14),
//       horizontalSpacing(10),
//       Icon(
//         Icons.calendar_month,
//         color: AppTheme.yellowButton,
//       ),
//     ]),
//   );
// }

LinearGradient customGradientWidget(
    {List<Color>? colors,
    AlignmentGeometry? begin = Alignment.bottomRight,
    AlignmentGeometry? end = Alignment.topLeft}) {
  return LinearGradient(begin: begin!, end: end!, colors: colors!);
}

// Future<DateTime> pickDate(BuildContext context) async {
//   DateTime? pickedDate = await showDatePicker(
//       context: context,
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(primary: AppTheme.primaryColor),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: AppTheme.primaryColor, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//       initialDate: DateTime.now(), //get today's date
//       firstDate: DateTime(
//           2000), //DateTime.now() - not to allow to choose before today.
//       lastDate: DateTime(2101));
//   if (pickedDate != null) {
//     return pickedDate;
//   } else {
//     return DateTime.now();
//   }
// }

GetSnackBar showSnackbarWidget(
    {Color backgroundColor = Colors.green,
    BuildContext? context,
    String? message,
    int duration = 3,
    Color? textColor = Colors.white}) {
  return GetSnackBar(
    // message: "success",
    messageText: text(
        giveText: message ?? '',
        fontsize: 14,
        textColor: textColor!,
        textAlignment: TextAlign.left,
        fontweight: FontWeight.w500),
    backgroundColor: backgroundColor,
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: duration),
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
  );
}

// Widget dropDownTextFormField(
//     {String? label,
//     required List items,
//     required void Function(String?) onSelected,
//     String? selectedText,
//     String? hintText,
//     double width = 300,
//     double height = 200,
//     bool isenumdata = false,
//     double buttonHeight = 40,
//     double selectedTextWidth = 200,
//     String? Function(String?)? validate,
//     TextEditingController? controller,
//     EdgeInsetsGeometry? contentPadding,
//     Color? lableColor = const Color(0xff29375F),
//     List<Widget> Function(BuildContext)? selectedItemBuilder,
//     Widget icon =
//         const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffC1C1C1)),

//     /*  List items =  ['Male', 'Female'], */
//     Color color = Colors.transparent}) {
//   return Container(
//     color: color,
//     child: DropdownButtonFormField2(
//         isExpanded: true,
//         searchController: controller,
//         buttonHeight: buttonHeight,
//         // hint: textMethod(text: "test"),

//         items: isenumdata
//             ? items
//                 .map((item) => DropdownMenuItem<String>(
//                     value: item.value,
//                     child: FittedBox(
//                       child: text(
//                           textAlignment: TextAlign.left,
//                           giveText: item.type.toString().capitalizeFirst!,
//                           fontsize: 14,
//                           fontweight: FontWeight.w400),
//                     )))
//                 .toList()
//             : items
//                 .map((item) => DropdownMenuItem<String>(
//                     value: item,
//                     child: FittedBox(
//                       child: text(
//                           textAlignment: TextAlign.left,
//                           giveText: item.toString().capitalizeFirst!,
//                           fontsize: 14,
//                           fontweight: FontWeight.w500),
//                     )))
//                 .toList(),
//         onChanged: onSelected,
//         validator: validate,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         // validator: validate,
//         // hint: hintText,
//         // customButton: const Text("bu"),
//         selectedItemBuilder: selectedItemBuilder,
//         icon: icon,
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         buttonWidth: width.sp,
//         itemHeight: 45.sp,
//         // buttonHeight: 20.sp,
//         iconSize: 20.sp,
//         value: isenumdata == true && items.any((e) => e.value == selectedText)
//             ? selectedText
//             : isenumdata == false && items.any((e) => e == selectedText)
//                 ? selectedText
//                 : null,
//         itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
//         // dropdownMaxHeight: height.sp,

//         dropdownWidth: width.sp,
//         buttonPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//         decoration: InputDecoration(
//             // label: label,
//             labelText: label,
//             errorStyle: GoogleFonts.getFont(
//               ('Poppins'),
//               fontSize: 14.sp,
//               textStyle: const TextStyle(),
//             ),
//             hintStyle: GoogleFonts.getFont(
//               ('Poppins'),
//               fontSize: 14.sp,
//               textStyle: TextStyle(
//                 color: AppTheme.loginInfoColor,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             hintText: hintText,
//             labelStyle: GoogleFonts.getFont(
//               ('Poppins'),
//               fontSize: 16.sp,
//               textStyle: TextStyle(
//                 color: lableColor,
//               ),
//             ),
//             contentPadding:
//                 const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
//             focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide:
//                     BorderSide(color: AppTheme.loginInfoColor, width: 1)),
//             errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppTheme.primaryColor, width: 1)),
//             disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                     color: AppTheme.loginInfoColor.withOpacity(0.14),
//                     width: 1)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide:
//                     BorderSide(color: AppTheme.loginInfoColor, width: 1)),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide:
//                     BorderSide(color: AppTheme.loginInfoColor, width: 1)))),
//   );
// }

// Widget calendarSF(controller, RxString date,
//     {TextEditingController? textEditingController}) {
//   return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10.sp,
//       ),
//       child: Material(
//         borderRadius: BorderRadius.circular(10.0.sp),
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(
//                           color: AppTheme.primaryColor.withOpacity(0.5)))),
//               padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   text(
//                       giveText: "Select Date",
//                       fontsize: 20,
//                       textColor: AppTheme.primaryColor,
//                       fontweight: FontWeight.w600),
//                   GestureDetector(
//                     onTap: () {
//                       controller.isCalendarVisible(false);
//                     },
//                     child: Icon(
//                       Icons.close,
//                       color: AppTheme.primaryColor,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 6.sp),
//                 child: CalendarDatePicker2(
//                     onValueChanged: (value) {
//                       // print(value);
//                       //  print(calendarTapDetails.date);
//                       // controller.pickedDate = value[0];

//                       date(value[0]!.toString());
//                       textEditingController?.text =
//                           DateFormat('dd-MM-yyyy').format(value[0]!);
//                       print(date.toString());
//                     },
//                     value: [DateTime.now()],
//                     config: CalendarDatePicker2Config(
//                         lastDate: DateTime.now(),
//                         selectedDayHighlightColor: AppTheme.primaryColor))),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20, right: 30),
//               child: alignRight(button(
//                   borderRadius: 10,
//                   // buttonWidth: Get.width,
//                   buttonHeight: 45.sp,
//                   buttonColor: Colors.transparent,
//                   onPress: () {
//                     controller.isCalendarVisible(false);
//                   },
//                   buttonText: "Done",
//                   buttonTextColor: AppTheme.primaryColor,
//                   textSize: 20,
//                   textWieght: FontWeight.w600)),
//             )
//           ],
//         ),
//       ));
// }

Future pickImage(ImageSource source) async {
  final image = await ImagePicker().pickImage(source: source);

  if (image != null) {
    return image.path.toString();
    // signupServices.upload(File(profile.value));
    // print(base64.encode(File(image.path).readAsBytesSync()));
  }
  return '';
}

Future<String> pickAndCompressImage(ImageSource source,
    {int compressionquality = 50}) async {
  final imagePicker = ImagePicker();
  final pickedImage = await imagePicker.pickImage(source: source);
  final compressionQuality = compressionquality;

  if (pickedImage != null) {
    final imagePath = pickedImage.path;

    final originalImageSize = await getImageSize(imagePath);
    print('Image Size Before Compressing :::: $originalImageSize');
    final compressedImage = await compressImage(imagePath, compressionQuality);

    final compressedImageSize = await getImageSize(compressedImage);
    print('Compressed Image Path: $compressedImage');
    print('Image Size After Compressing :::: $compressedImageSize');

    return compressedImage;
  }

  return '';
}

Future<String> compressImage(String imagePath, int compressionQuality) async {
  final tempDir = await getTemporaryDirectory();
  final targetPath = '${tempDir.path}/compressed_image.jpg';

  final compressedImage = await FlutterImageCompress.compressAndGetFile(
    imagePath,
    targetPath,
    quality: compressionQuality,
  );
  return compressedImage!.path;
}

Future<String> getImageSize(String imagePath) async {
  var file = File(imagePath);
  int size = await file.length();
  if (size <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (math.log(size) / math.log(1024)).floor();
  return '${(size / math.pow(1024, i)).toStringAsFixed(3)} ${suffixes[i]}';
}

AppBar appBarWidget(String title) {
  return AppBar(
      centerTitle: true,
      elevation: 1,
      leading: backArrow(giveIconSize: 18, giveIconColor: Colors.black87),
      title: text(
          giveText: title,
          fontsize: 15,
          fontweight: FontWeight.w400,
          textColor: AppTheme.textColor));
}

Widget typeButton(
    String path, bool isEnabled, String textString, RxString selectedString) {
  return GestureDetector(
    onTap: () {
      selectedString(textString);
    },
    child: Column(
      children: [
        Container(
          height: 100,
          width: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(BorderSide(
                  color: isEnabled ? AppTheme.mainColor : Colors.white,
                  width: 2))),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Image.asset(
              path,
            ),
          ),
        ),
        text(giveText: textString, fontsize: 12, fontweight: FontWeight.w400)
      ],
    ),
  );
}
