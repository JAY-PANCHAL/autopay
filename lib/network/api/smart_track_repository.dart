import 'package:autopay/network/api/smart_track_api.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as gets;

import '../../common/utils/app_constants.dart';
import '../../common/utils/storage_service.dart';
import '../../routes/app_pages.dart';
import '../constant/endpoints.dart';
import '../dio/dio_exception.dart';


class SmartTrackRepository {
  final SmartTrackApi smartTrackApi;
  final storageService = StorageService();

  SmartTrackRepository(this.smartTrackApi);

 /* Future<LoginModel> login(params) async {
    try {
      final response = await smartTrackApi.loadPostData(
        Endpoints.login,
        params,
      );
      return LoginModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {
        // await StorageService().clearData();
        // gets.Get.offAllNamed(Routes.login);
      }
      throw errorMessage;
    }
  }

  Future<EmpDetailsModel> empDetails() async {
    var token = await storageService.getString(AppConstants.tokenPr);
    try {
      final response = await smartTrackApi.loadGetData(
        Endpoints.getEmpData,
        token,
      );
      return EmpDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }*/
}
