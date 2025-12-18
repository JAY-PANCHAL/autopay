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

  static const String singup = 'api/user/registration ';
  static const String login = 'api/login';
  static const String countries = "api/countries";
  static const String states = "api/states";

}
