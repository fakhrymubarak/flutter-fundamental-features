import 'package:get/instance_manager.dart';
import 'package:rpl_apps_flutter/controller/camera_controller.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CameraController());
  }
}
