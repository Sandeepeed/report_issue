import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ReportController extends GetxController {
  RxString imageSelected = ''.obs;
  FirebaseAuth instance = FirebaseAuth.instance;
  TextEditingController descriptionController = TextEditingController();
  Rx<LatLng> pickedLocationData = const LatLng(0, 0).obs;
  Reference storageReference = FirebaseStorage.instance.ref();
  RxString url = ''.obs;
  FirebaseFirestore dbInstance = FirebaseFirestore.instance;
  Rx<LocationData>? locationData =
      LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}).obs;
  RxBool locationLoaded = false.obs;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<void> uploadImage() async {
    File imageFile = File(imageSelected.value);
    storageReference = firebaseStorage.ref().child(imageFile.path);
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    url(await taskSnapshot.ref.getDownloadURL());
    printInfo(info: "${url.value} - File URL");
  }

  Future<void> uploadToFirestore() async {
    final data = {
      'imgPath': url.value,
      'description': descriptionController.text,
      'lat': pickedLocationData.value.latitude,
      'lng': pickedLocationData.value.longitude,
      'type': selectedType.value.toLowerCase(),
      'user': instance.currentUser!.displayName!,
      'time': DateTime.now().toString(),
    };
    dbInstance.collection('reports').doc().set(data, SetOptions(merge: true));
  }

  Location location = Location();

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

  Future<void> getLocationCurernt() async {
    locationLoaded(false);
    locationData!(await getLocationPermission());
    locationLoaded(true);

    printInfo(info: "${locationData!.value.latitude!}lat");
  }

  RxString selectedType = 'Breakdown'.obs;

  // Future<void> getAddress() async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //       pickedLocationData.value.latitude, pickedLocationData.value.longitude);
  //       printInfo(info: placemarks[0].street.toString());
  // }
  @override
  void onInit() {
    // TODO: implement onInit
    getLocationCurernt();
    super.onInit();
  }
}
