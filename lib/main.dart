import 'package:autopay/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'common/dependency_injection.dart';
import 'common/service_locator.dart';
import 'common/utils/color_constants.dart';
import 'common/utils/storage_service.dart';
import 'common/utils/strings.dart';
import 'network/service/check_internet_service.dart';

// final GlobalKey<NavigatorState> navigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: "navigator");

// Future<void> backgroundHandler(RemoteMessage message) async {
//   print('Handling a background message ${message.messageId}');
// }

// final CommonController commonController = Get.put((CommonController()));
final internetService = Get.put(InternetService());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // NotificationHelper().initNotification(navigatorKey);
  // await ExcelService.initNotifications();

  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await DependencyInjection.init();
  setup();
  Get.put(StorageService());

  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  await internetService.init(() {
    // This method will be called when internet is restored
    // commonController.callPostMilkCollection(true);
  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //HttpOverrides.global = MyHttpOverrides();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OeHealthApp(),
    color: AppColors.appColor,
  ));
}

class OeHealthApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AsaanAppState();
  }
}

class AsaanAppState extends State<OeHealthApp> {
/*  final PushNotificationService _notificationService =
      PushNotificationService();*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      initialRoute: Routes.root,
      getPages: AppPages.routes,
      title: Strings.appName,
    );
  }
}
