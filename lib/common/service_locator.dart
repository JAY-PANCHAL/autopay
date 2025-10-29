import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api/smart_track_api.dart';
import '../network/api/smart_track_repository.dart';
import '../network/dio/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(SmartTrackApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(SmartTrackRepository(getIt.get<SmartTrackApi>()));
  // getIt.registerSingleton(HomeController());
}
