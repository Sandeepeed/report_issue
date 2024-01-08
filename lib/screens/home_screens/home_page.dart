import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:report_issue/controllers/home_controller.dart';
import 'package:report_issue/screens/home_screens/complaints_page.dart';
import 'package:report_issue/screens/home_screens/report_issue.dart';
import 'package:report_issue/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const ReportIssue());
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: AppTheme.mainColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.sp, horizontal: 0.sp),
        child: Obx(() => Visibility(
              visible: controller.complaintsPage.isTrue,
              replacement: Stack(
                children: [
                  Obx(() => Visibility(
                        visible: controller.locationLoaded.value,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: Obx(
                              () => GoogleMap(
                                markers: controller.markers.values.toSet(),
                                onTap: (argument) {
                                  controller.customInfoWindowController
                                      .hideInfoWindow!();
                                },
                                onMapCreated: (mapController) async {
                                  controller.customInfoWindowController
                                      .googleMapController = mapController;

                                  await controller
                                      .onMapCreated(mapController)
                                      .then((value) {});
                                },
                                mapToolbarEnabled: false,
                                padding: const EdgeInsets.only(
                                  top: 40.0,
                                ),
                                onCameraMove: (position) {
                                  printInfo(
                                      info:
                                          position.target.latitude.toString());
                                },
                                myLocationButtonEnabled: true,
                                onCameraMoveStarted: () {},
                                tiltGesturesEnabled: false,
                                zoomControlsEnabled: false,
                                myLocationEnabled: true,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      controller.locationData!.value.latitude!,
                                      controller
                                          .locationData!.value.longitude!),
                                  zoom: 15.0,
                                ),
                              ),
                            )),
                      )),
                  CustomInfoWindow(
                    controller: controller.customInfoWindowController,
                    height: 100,
                    width: 300,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 50.sp),
                      child: InkWell(
                        onTap: () {
                          controller.complaintsPage(true);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: kElevationToShadow[2],
                                borderRadius: BorderRadius.circular(2.sp)),
                            child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: const Icon(Icons.window))),
                      ))
                ],
              ),
              child: const ComplaintPage(),
            )),
      ),
    );
  }
}
