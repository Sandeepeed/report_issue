import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:report_issue/controllers/signin_controller.dart';
import 'package:report_issue/screens/login_screens/signin_screen.dart';
import 'package:report_issue/utils/colors.dart';
import 'package:report_issue/utils/reusable_widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find<SignInController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacing(30),
              text(
                  giveText: "Create a new account",
                  textColor: AppTheme.mainColor,
                  fontsize: 24,
                  fontweight: FontWeight.w600),
              // text(
              //     fontfamily: 'Open Sans',
              //     giveText: "Log in to report a pothole near you",
              //     textColor: AppTheme.textColor,
              //     fontsize: 14,
              //     fontweight: FontWeight.w400),
              verticalSpacing(40),
              textField(
                  fieldController: controller.name,
                  onFieldEntry: (text) {},
                  lableTextSize: 14,
                  borderRadius: 4,
                  hintText: "Enter Username",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
                  giveHint: "Name",
                  hintTextSize: 12,
                  labelColor: AppTheme.textColor.withOpacity(0.8),
                  borderColor: Colors.grey),
              verticalSpacing(20),
              textField(
                  fieldController: controller.email,
                  onFieldEntry: (text) {},
                  lableTextSize: 14,
                  borderRadius: 4,
                  hintText: "Enter Email",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
                  giveHint: "Email",
                  hintTextSize: 12,
                  labelColor: AppTheme.textColor.withOpacity(0.8),
                  borderColor: Colors.grey),
              verticalSpacing(20),
              textField(
                  fieldController: controller.passoword,
                  onFieldEntry: (text) {},
                  lableTextSize: 14,
                  borderRadius: 4,
                  hintText: "Enter Password",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
                  giveHint: "Password",
                  hintTextSize: 12,
                  labelColor: AppTheme.textColor.withOpacity(0.8),
                  borderColor: Colors.grey),

              verticalSpacing(30),
              SizedBox(
                width: Get.width,
                child: button(
                    buttonHeight: 45.sp,
                    borderRadius: 10,
                    buttonColor: AppTheme.mainColor,
                    onPress: () {
                      controller.signUpWithEmailPassword();
                    },
                    textSize: 14,
                    buttonText: "Sign Up"),
              ),
              verticalSpacing(10),
              SizedBox(
                width: Get.width,
                child: button(
                    buttonHeight: 45.sp,
                    borderRadius: 10,
                    buttonColor: AppTheme.mainColor,
                    onPress: () {
                      controller.signInWithGoogle();
                    },
                    textSize: 14,
                    buttonText: "Sign Up With Google"),
              ),
              verticalSpacing(20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    text(
                        giveText: "Already have an account?",
                        textColor: AppTheme.textColor,
                        fontsize: 12,
                        fontweight: FontWeight.w400),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SignInScreen());
                      },
                      child: text(
                          giveText: "Sign In",
                          textColor: AppTheme.mainColor,
                          fontsize: 14,
                          fontweight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
