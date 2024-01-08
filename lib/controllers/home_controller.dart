import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:report_issue/utils/reusable_widgets.dart';

class HomeController extends GetxController {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  FirebaseAuth auth = FirebaseAuth.instance;
  logout() {
    auth.signOut();
  }

  RxBool complaintsPage = false.obs;
  late GoogleMapController googleController;
  Rx<LatLng> northVisibleRegion = const LatLng(0, 0).obs;
  Rx<LatLng> southVisibleRegion = const LatLng(0, 0).obs;

  Future<void> onMapCreated(GoogleMapController controller) async {
    googleController = controller;

    controller.getVisibleRegion().then((LatLngBounds value) {
      northVisibleRegion(value.northeast);
      southVisibleRegion(value.southwest);
      printInfo(
          info:
              "${northVisibleRegion.value.latitude} ${northVisibleRegion.value.longitude}");
    });
  }

  RxList<ReportModel> reportData = <ReportModel>[].obs;
  Location location = Location();
  FirebaseFirestore dbInstance = FirebaseFirestore.instance;
  Future<void> getReports() async {
    reportData.clear();
    final docRef = dbInstance.collection('reports');
    await docRef.get().then(
      (QuerySnapshot doc) {
        for (var docSnapshot in doc.docs) {
          printInfo(info: '${docSnapshot.id} => ${docSnapshot['imgPath']}');
          reportData.add(
              ReportModel.fromJson(docSnapshot.data() as Map<String, dynamic>));
          addToMarkersList(
              LatLng(docSnapshot['lat'], docSnapshot['lng']),
              docSnapshot.id,
              docSnapshot['imgPath'],
              docSnapshot['type'],
              docSnapshot['user'],
              docSnapshot['time']);
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  RxMap<String, Marker> markers = <String, Marker>{}.obs;
  Future<LocationData> getLocationPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      return Future.error('Service Disabled');
    } else {
      serviceEnabled = await location.requestService();
      if (serviceEnabled == false) {
        return Future.error('Service Disabled');
      } else {
        return location.getLocation();
      }
    }
  }

  Future<void> addToMarkersList(LatLng latLng, String id, String imgURL,
      String type, String user, String dateTime) async {
    markers.clear();
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size.zero),
        type == "breakdown"
            ? "icons/breakdown.png"
            : type == 'roadwork'
                ? "icons/roadwork.png"
                : "icons/patient.png");
    var marker = Marker(
        markerId: MarkerId('value$id'),
        position: latLng,
        icon: icon,
        onTap: () async {
          final cameraPosition = CameraPosition(
              target: latLng, zoom: await googleController.getZoomLevel());
          await googleController
              .moveCamera(CameraUpdate.newCameraPosition(cameraPosition))
              .then((value) {
            customInfoWindowController.addInfoWindow!(
                Container(
                    padding: EdgeInsets.all(6.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        networkImageMethod(
                            width: 70.sp,
                            height: 80.sp,
                            fit: BoxFit.cover,
                            assetName: imgURL),
                        horizontalSpacing(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            text(
                                giveText:
                                    "Issue Reported: ${dateFormat.format(DateTime.parse(dateTime))}",
                                fontsize: 10,
                                fontfamily: 'Open Sans'),
                            text(
                                giveText: "Type of Issue: ${type.capitalize!}",
                                fontsize: 10,
                                fontfamily: 'Open Sans'),
                            text(
                                giveText: "Reported by: $user",
                                fontsize: 10,
                                fontfamily: 'Open Sans'),
                          ],
                        ),
                      ],
                    )),
                latLng);
          });
        });
    markers[id] = marker;
  }

  DateFormat dateFormat = DateFormat('yyyy-mm-dd');
  Rx<LocationData>? locationData =
      LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}).obs;
  RxBool locationLoaded = false.obs;
  Future<void> getLocationCurernt() async {
    locationLoaded(false);
    locationData!(await getLocationPermission());
    locationLoaded(true);

    printInfo(info: "${locationData!.value.latitude!}lat");
  }

  @override
  void onInit() {
    getLocationCurernt().then((value) {
      getReports();
    });

    super.onInit();
  }
}

class ReportModel {
  double lng;
  double lat;
  String imgPath;
  String desc;
  String type;
  // DateTime dateTime;
  String user;
  String dateTime;
  ReportModel(
      {required this.desc,
      required this.dateTime,
      required this.user,
      required this.type,
      required this.imgPath,
      required this.lat,
      required this.lng});
  factory ReportModel.fromJson(Map<String, dynamic> jsonData) {
    return ReportModel(
        user: jsonData['user'],
        dateTime: jsonData['time'],
        type: jsonData['type'],
        desc: jsonData['description'],
        imgPath: jsonData['imgPath'],
        lat: jsonData['lat'],
        lng: jsonData['lng']);
  }
}
