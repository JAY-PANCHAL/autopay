import 'package:autopay/network/api/smart_track_api.dart';
import 'package:autopay/network/model/signup_Distributor_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as gets;

import '../../common/utils/app_constants.dart';
import '../../common/utils/storage_service.dart';
import '../../routes/app_pages.dart';
import '../constant/endpoints.dart';
import '../dio/dio_exception.dart';
import '../model/token_model.dart';


class AutomapRepository {
  final AutomapApi automapApi;
  final storageService = StorageService();

  AutomapRepository(this.automapApi);
  Future<TokenModel> token(params) async {
    try {
      final response = await automapApi.loadGetDataWithParams(
        Endpoints.token,
        params,""
      );
      return TokenModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {
        // await StorageService().clearData();
        // gets.Get.offAllNamed(Routes.login);
      }
      throw errorMessage;
    }
  }

  Future<SignupDistibutorModel> signupDistributor(params,token) async {
    try {
      final response = await automapApi.loadPostDataToken(
          Endpoints.token,
          params,token
      );
      return SignupDistibutorModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {
        // await StorageService().clearData();
        // gets.Get.offAllNamed(Routes.login);
      }
      throw errorMessage;
    }
  }

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
