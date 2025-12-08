import '../../common/utils/storage_service.dart';

class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://automap.braincrew-apps.com/"; //new

  // receiveTimeout
  static const int receiveTimeout = 250000;

  // connectTimeout
  static const int connectionTimeout = 250000;
  final StorageService storageService = StorageService();
  static const String token = 'request/token';

  static const String singup = 'user/registration';
}
