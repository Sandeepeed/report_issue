import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:report_issue/controllers/report_controller.dart';
import 'package:report_issue/utils/colors.dart';
import 'package:report_issue/utils/reusable_widgets.dart';

class PickLocationWidget extends StatelessWidget {
  const PickLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportController>();
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => SizedBox(
                height: Get.height,
                width: Get.width,
                child: GoogleMap(
                  mapToolbarEnabled: false,
                  padding: const EdgeInsets.only(
                    top: 40.0,
                  ),
                  onCameraMove: (position) {
                    controller.pickedLocationData(position.target);
                  },
                  myLocationButtonEnabled: true,
                  tiltGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(controller.locationData!.value.latitude!,
                        controller.locationData!.value.longitude!),
                    zoom: 20.0,
                  ),
                ),
              )),
          const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.location_on,
                size: 40,
                color: AppTheme.textColor,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: button(
                  buttonWidth: Get.width,
                  buttonHeight: 50,
                  buttonColor: AppTheme.mainColor,
                  onPress: () {
                    printInfo(
                        info: controller.pickedLocationData.value.latitude
                            .toString());
                    Get.back();
                  },
                  buttonText: 'Pick This Location'),
            ),
          )
        ],
      ),
    );
  }
}
