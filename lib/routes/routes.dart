import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:rpl_apps_flutter/routes/binding/camera_binding.dart';
import 'package:rpl_apps_flutter/views/audio_page.dart';
import 'package:rpl_apps_flutter/views/camera_page.dart';
import 'package:rpl_apps_flutter/views/geo_locator_page.dart';
import 'package:rpl_apps_flutter/views/home_page.dart';

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
  ];
}
