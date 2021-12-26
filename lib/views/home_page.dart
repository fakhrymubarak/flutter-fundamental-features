import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:rpl_apps_flutter/themes/button_styles.dart';
import 'package:rpl_apps_flutter/utils/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _incrementCounter() {}

  void setNotificationAndroid() {
    NotificationService notificationService = NotificationService();
    notificationService.showNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        setNotificationAndroid();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Notification'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Special Notification'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/geo_locator');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Geo-Location'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        Get.toNamed('/camera');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Camera Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Speaker Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Microphone Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Contact Book'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Fingerprint Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Cellular Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Wifi Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Bluetooth Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Bluetooth Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Infrared Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('NFC Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Accelerometer Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Magnetometer Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Gyroscope Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Data Cellular Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Device Serial Number'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('IMEI Access'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: buttonPrimaryLarge,
                      onPressed: () {
                        _incrementCounter();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: const Text('Non-Connection (Caching)'),
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
