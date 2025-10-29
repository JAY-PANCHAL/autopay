import 'package:get/get.dart';

import 'storage_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}