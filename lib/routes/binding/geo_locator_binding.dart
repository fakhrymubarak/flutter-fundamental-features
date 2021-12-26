import 'package:get/instance_manager.dart';
import 'package:rpl_apps_flutter/controller/geo_locator_controller.dart';

class GeoLocatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GeoLocatorController());
  }
}
