import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rpl_apps_flutter/controller/geo_locator_controller.dart';

class GeoLocatorPage extends StatefulWidget {
  const GeoLocatorPage({Key? key}) : super(key: key);

  @override
  _GeoLocatorPageState createState() => _GeoLocatorPageState();
}

class _GeoLocatorPageState extends State<GeoLocatorPage> {
  final GeoLocatorController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Obx(
            () => _controller.geoLocatorValue.value.latitude == null
                ? const CircularProgressIndicator()
                : _successWidgets(_controller.geoLocatorValue.value),
          ),
        ),
      ),
    );
  }

  _successWidgets(GeoLocator value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 16.h),
        Text("latitude = ${value.latitude}"),
        SizedBox(height: 16.h),
        Text("longitude = ${value.longitude}"),
        SizedBox(height: 16.h),
        Text("altitude = ${value.altitude}"),
        SizedBox(height: 16.h),
        Text("accuracy = ${value.accuracy}"),
        SizedBox(height: 16.h),
        Text("timestamp = ${value.timestamp}"),
        SizedBox(height: 16.h),
        Text("speed = ${value.speed}"),
        SizedBox(height: 16.h),
        Text("speedAccuracy = ${value.speedAccuracy}"),
      ],
    );
  }
}
