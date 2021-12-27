import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rpl_apps_flutter/routes/routes.dart';
import 'package:rpl_apps_flutter/utils/notification.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const MyApp());
  CacheManager.logLevel = CacheManagerLogLevel.verbose;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        title: 'Flutter Fundamental Features',
        getPages: Routes.route,
        initialRoute: '/home',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
