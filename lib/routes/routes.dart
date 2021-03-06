import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:rpl_apps_flutter/routes/binding/camera_binding.dart';
import 'package:rpl_apps_flutter/views/audio_page.dart';
import 'package:rpl_apps_flutter/views/biometrics_page.dart';
import 'package:rpl_apps_flutter/views/bluetooth_page.dart';
import 'package:rpl_apps_flutter/views/cache_page.dart';
import 'package:rpl_apps_flutter/views/camera_page.dart';
import 'package:rpl_apps_flutter/views/cellular_number_page.dart';
import 'package:rpl_apps_flutter/views/connectivity_page.dart';
import 'package:rpl_apps_flutter/views/contact_page.dart';
import 'package:rpl_apps_flutter/views/device_info_page.dart';
import 'package:rpl_apps_flutter/views/geo_locator_page.dart';
import 'package:rpl_apps_flutter/views/home_page.dart';
import 'package:rpl_apps_flutter/views/ir_sensor_page.dart';
import 'package:rpl_apps_flutter/views/mic_page.dart';
import 'package:rpl_apps_flutter/views/nfc_page.dart';
import 'package:rpl_apps_flutter/views/sensor_page.dart';

import 'binding/geo_locator_binding.dart';

class Routes {
  static final route = [
    GetPage(name: '/home', page: () => const HomePage()),
    GetPage(
      name: '/geo_locator',
      page: () => const GeoLocatorPage(),
      binding: GeoLocatorBinding(),
    ),
    GetPage(
      name: '/camera',
      page: () => const CameraPage(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: '/audio',
      page: () => const AudioPage(
          url: "https://filesamples.com/samples/audio/mp3/sample1.mp3"),
    ),
    GetPage(name: '/mic', page: () => const MicPage()),
    GetPage(name: '/contact', page: () => const ContactListPage()),
    GetPage(name: '/biometrics', page: () => const BiometricsPage()),
    GetPage(name: '/connectivity', page: () => const ConnectivityPage()),
    GetPage(name: '/bluetooth', page: () => const BluetoothPage()),
    GetPage(name: '/ir', page: () => const IrSensorPage()),
    GetPage(name: '/nfc', page: () => NFCPage()),
    GetPage(name: '/sensors', page: () => SensorsPage()),
    GetPage(name: '/phoneNumber', page: () => const CellularNumberPage()),
    GetPage(name: '/deviceInfo', page: () => const DeviceInfoPage()),
    GetPage(name: '/cache', page: () => const CachePage()),
  ];
}
