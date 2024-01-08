import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_issue/controllers/home_controller.dart';
import 'package:report_issue/controllers/report_controller.dart';
import 'package:report_issue/utils/colors.dart';
import 'package:report_issue/utils/map_widget.dart';
import 'package:report_issue/utils/reusable_widgets.dart';

class ReportIssue extends StatelessWidget {
  const ReportIssue({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final controller = Get.put(ReportController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.sp),
        child: button(
            buttonWidth: Get.width,
            buttonHeight: 50,
            buttonColor: AppTheme.mainColor,
            onPress: () {
              printInfo(
                  info: "${controller.pickedLocationData.value.latitude}lattt");
              if (controller.pickedLocationData.value.latitude != 0.0) {
                if (controller.imageSelected.value != '' ||
                    controller.descriptionController.text != '') {
                  controller.uploadImage().then((value) {
                    controller.uploadToFirestore().then((value) {
                      homeController.getReports();
                      Get.back();
                    });
                  });
                } else {
                  printInfo(info: "this hapeening");
                  Get.showSnackbar(showSnackbarWidget(
                      backgroundColor: Colors.red,
                      message: "Enter all Details",
                      context: context));
                }
              } else {
                Get.showSnackbar(showSnackbarWidget(
                    backgroundColor: Colors.red,
                    message: "Pick Location",
                    context: context));
              }
            },
            buttonText: 'Upload'),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppTheme.mainColor,
              ),
            ),
            horizontalSpacing(10),
            text(
                giveText: "Report issue",
                textColor: AppTheme.mainColor,
                fontsize: 18,
                fontweight: FontWeight.w600),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  controller
                      .imageSelected(await pickImage(ImageSource.gallery));
                },
                child: Obx(() => Visibility(
                      visible: controller.imageSelected.value != '',
                      replacement: DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 1,
                          child: SizedBox(
                            width: Get.width,
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                verticalSpacing(10),
                                text(
                                    giveText: "Add Image",
                                    textColor: Colors.grey),
                              ],
                            ),
                          )),
                      child: SizedBox(
                        width: Get.width,
                        height: 300,
                        child: Image.file(File(controller.imageSelected.value)),
                      ),
                    )),
              ),
              verticalSpacing(30),
              SizedBox(
                height: 100,
                child: textField(
                    isExpand: true,
                    fieldMaxLines: null,
                    giveHeight: 200,
                    fieldController: controller.descriptionController,
                    onFieldEntry: (text) {},
                    lableTextSize: 14,
                    borderRadius: 4,
                    hintText: "Enter Description",
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 15.sp),
                    giveHint: "Description",
                    hintTextSize: 12,
                    labelColor: AppTheme.textColor.withOpacity(0.8),
                    borderColor: Colors.grey),
              ),
              verticalSpacing(20),
              Obx(
                () => textField(
                  onFieldTap: () {
                    Get.to(() => const PickLocationWidget());
                  },
                  borderColor: Colors.grey,
                  hintText: "Pick Location",
                  isFieldReadOnly: true,
                  borderRadius: 4,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
                  hintTextSize: 12,
                  labelColor: AppTheme.textColor.withOpacity(0.8),
                  fieldController: TextEditingController(
                      text:
                          "Latitude and Longitude: ${controller.pickedLocationData.value.latitude} ${controller.pickedLocationData.value.longitude}"),
                  onFieldEntry: (e) {},
                ),
              ),
              verticalSpacing(10),
              text(
                  giveText: "Choose Type Of Accident",
                  fontsize: 14,
                  fontweight: FontWeight.w600),
              verticalSpacing(20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      typeButton(
                          'icons/breakdownDisplay.png',
                          controller.selectedType.value == 'Breakdown',
                          "Breakdown",
                          controller.selectedType),
                      typeButton(
                          'icons/patientDisplay.png',
                          controller.selectedType.value == 'Accident',
                          "Accident",
                          controller.selectedType),
                      typeButton(
                          'icons/roadworkDisplay.png',
                          controller.selectedType.value == 'Roadwork',
                          "Roadwork",
                          controller.selectedType),
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
