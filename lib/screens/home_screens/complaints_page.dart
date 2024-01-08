import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:report_issue/controllers/home_controller.dart';
import 'package:report_issue/utils/colors.dart';
import 'package:report_issue/utils/reusable_widgets.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                controller.complaintsPage(false);
              },
              child: text(
                  giveText: "Switch View",
                  textColor: Colors.white,
                  fontsize: 12)),
          horizontalSpacing(10),
        ],
        backgroundColor: AppTheme.mainColor,
        centerTitle: true,
        title: text(
            giveText: "Complaints",
            fontsize: 18,
            textColor: Colors.white,
            fontweight: FontWeight.w600),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.reportData.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 10.sp),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.sp, horizontal: 10.sp),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: kElevationToShadow[2]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          networkImageMethod(
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              assetName: controller.reportData[index].imgPath),
                          horizontalSpacing(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(
                                giveText: controller
                                    .reportData[index].desc.capitalizeFirst!,
                                fontsize: 18,
                                fontfamily: 'Open Sans',
                                fontweight: FontWeight.w600,
                              ),
                              text(
                                giveText:
                                    "Date of Incident: ${controller.dateFormat.format(DateTime.parse(controller.reportData[index].dateTime))}",
                                fontsize: 12,
                                fontfamily: 'Open Sans',
                                fontweight: FontWeight.w400,
                              ),
                              text(
                                giveText:
                                    "Reported by: ${controller.reportData[index].user}",
                                fontsize: 12,
                                fontfamily: 'Open Sans',
                                fontweight: FontWeight.w400,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
