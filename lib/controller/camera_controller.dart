import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class CameraController extends GetxController {
  final Rx<Camera> cameraFirst = Camera(null).obs;

  @override
  void onInit() {
    _getFirstCamera().then((value) => cameraFirst.value = Camera(value));
    super.onInit();
  }

  Future<CameraDescription> _getFirstCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    return cameras.first;
  }
}

class Camera {
  CameraDescription? cameraDesc;

  Camera(this.cameraDesc);
}
