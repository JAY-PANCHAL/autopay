import 'package:autopay/network/api/smart_track_api.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as gets;

import '../../common/utils/storage_service.dart';
import '../../routes/app_pages.dart';
import '../constant/endpoints.dart';
import '../dio/dio_exception.dart';
import '../model/sub_process_model.dart';
import '../model/todays_status_model.dart';

class SmartTrackRepository {
  final SmartTrackApi smartTrackApi;
  final storageService = StorageService();

  SmartTrackRepository(this.smartTrackApi);

  Future<LoginModel> login(params) async {
    try {
      final response =
          await smartTrackApi.loadPostData(Endpoints.login, params);
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
      final response =
          await smartTrackApi.loadGetData(Endpoints.getEmpData, token);
      return EmpDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }

  Future<QCDetailsModel> qcDetails() async {
    var token = await storageService.getString(AppConstants.tokenPr);
    try {
      final response =
          await smartTrackApi.loadGetData(Endpoints.getQCData, token);
      return QCDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }

  Future<SubProcessModel> subProcessData(params) async {
    var token = await storageService.getString(AppConstants.tokenPr);
    try {
      final response = await smartTrackApi.loadPostDataToken(
          Endpoints.subProcessData, params, token);
      return SubProcessModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }

  Future<ReasonsModel> reasonMaster() async {
    var token = await storageService.getString(AppConstants.tokenPr);
    try {
      final response =
          await smartTrackApi.loadGetData(Endpoints.getReasonsMaster, token);
      return ReasonsModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }

  Future<BagInfoModel> bagInfo(params) async {
    var token = await storageService.getString(AppConstants.tokenPr);
    print(params);
    try {
      final response = await smartTrackApi.loadPostDataToken(
          Endpoints.getBagInfo, params, token);
      if (response.data != null && response.data is Map<String, dynamic>) {
        return BagInfoModel.fromJson(response.data);
      } else {
        return BagInfoModel();
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }

  Future<BagListModel> bagList(params) async {
    var token = await storageService.getString(AppConstants.tokenPr);
    print(params);
    try {
      final response = await smartTrackApi.loadPostDataToken(
          Endpoints.getBagList, params, token);
      return BagListModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }

  Future<InsertBagModel> workerBagEntry(params) async {
    var token = await storageService.getString(AppConstants.tokenPr);
    print(params);
    try {
      final response = await smartTrackApi.loadPostDataToken(
          Endpoints.workerBagEntry, params, token);
      return InsertBagModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }

  Future<QCInwardModel> qcEntry(params) async {
    var token = await storageService.getString(AppConstants.tokenPr);
    print(params);
    try {
      final response = await smartTrackApi.loadPostDataToken(
          Endpoints.workerQcEntry, params, token);
      return QCInwardModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }
  Future<TodaysStatusModel> getTodayStatus(params) async {
    var token = await storageService.getString(AppConstants.tokenPr);
    print(params);
    try {
      final response = await smartTrackApi.loadGetDataWithParams(
          Endpoints.getTodayStatus, params, token);
      return TodaysStatusModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (errorMessage == "Bad request") {}
      throw errorMessage;
    }
  }

  // Future<VerifyOtpModel> verifyOTP(params) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataJsonType(
  //         Endpoints.verifyOtp, params, null);
  //     return VerifyOtpModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<GetMemberCountResponse> getMemberCount(token) async {
  //   try {
  //     final response =
  //         await smartTrackApi.loadGetData(Endpoints.getMemberCount, token);
  //     return GetMemberCountResponse.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<MemberDataModel> getMemberData(token, params) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataToken(
  //         Endpoints.getMemberData, params, token);
  //     return MemberDataModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<LocationModel> getlocationMaster(params) async {
  //   try {
  //     final response = await smartTrackApi.loadGetDataWithParams(
  //         Endpoints.locationMaster, params, "");
  //     return LocationModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<LocationInsertModel> getlocationInsert(params) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataToken(
  //         Endpoints.locationInsert, params, "");
  //     return LocationInsertModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<dynamic> confirmMemberData(token, params) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataToken(
  //         Endpoints.confirmMemberData, params, token);
  //     return response.data;
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<MaxOfMemberCode> getMaxOfMemberCode(token) async {
  //   try {
  //     final response =
  //         await smartTrackApi.loadGetData(Endpoints.maxofMembers, token);
  //     return MaxOfMemberCode.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<LstLocalSalesIDModel> getLastLocalSalesIDApi(token) async {
  //   try {
  //     final response =
  //         await smartTrackApi.loadGetData(Endpoints.getLastLocalsalesID, token);
  //     return LstLocalSalesIDModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<LstLocalSalesIDModel> getLastpayDeductionIDApi(token) async {
  //   try {
  //     final response = await smartTrackApi.loadGetData(
  //         Endpoints.getLastPayDeductionID, token);
  //     return LstLocalSalesIDModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<BankMasterModel> getBankMasterApi(token) async {
  //   try {
  //     final response =
  //         await smartTrackApi.loadGetData(Endpoints.getBankMaster, token);
  //     return BankMasterModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<DataRelatedSettingsModel> getDataRelatedSettingApi(token) async {
  //   try {
  //     final response = await smartTrackApi.loadGetData(
  //         Endpoints.getDataRelatedSetting, token);
  //     return DataRelatedSettingsModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<SessionSettingsModel> getSessionRelatedSettingApi(token) async {
  //   try {
  //     final response = await smartTrackApi.loadGetData(
  //         Endpoints.getSessionRelatedSetting, token);
  //     return SessionSettingsModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<RateRelatedSettingsModel> getRateRelatedSettingApi(token) async {
  //   try {
  //     final response = await smartTrackApi.loadGetData(
  //         Endpoints.getRateRelatedSetting, token);
  //     return RateRelatedSettingsModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<FatBasedRateChartCountModel> getFATBasedRateChartCountApi(
  //     token) async {
  //   try {
  //     final response = await smartTrackApi.loadGetData(
  //         Endpoints.getFATBasedRateChartCount, token);
  //     return FatBasedRateChartCountModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<FatBasedRateChartModel> getFATBasedRateChartApi(token, params) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataToken(
  //         Endpoints.getFATBasedRateChart, params, token);
  //     return FatBasedRateChartModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<FatBasedRateChartModel> confirmFATBasedRateChartApi(
  //     token, params) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataToken(
  //         Endpoints.confirmFATBasedRateChart, params, token);
  //     return FatBasedRateChartModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<GetAsaanAppMenu> getAsanAppMenuApi(token) async {
  //   try {
  //     final response =
  //         await smartTrackApi.loadGetData(Endpoints.getAsaanAppMenu, token);
  //     return GetAsaanAppMenu.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<dynamic> getConfirmNotificaion(token, endpoint) async {
  //   try {
  //     final response = await smartTrackApi.loadGetData(endpoint, token);
  //     return response.data;
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // /*Future<GetAsaanAppMenu>getAsanAppUserRoleApi(token) async {
  //   try {
  //     final response =
  //     await smartTrackApi.loadGetData(Endpoints.getAsaanAppMenu,token);
  //     return GetAsaanAppMenu.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //      if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }*/

  // Future<MaxAutoID> getlastCollectionID(token) async {
  //   try {
  //     final response =
  //         await smartTrackApi.loadGetData(Endpoints.getLastCollectionId, token);
  //     return MaxAutoID.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<PostMilkCollectionModel> postMilkCollection(params, token) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataJsonType(
  //         Endpoints.postMilkCollection, params, token);
  //     return PostMilkCollectionModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<GetMilkCollectionModel> getMilkCollection(token, params) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataToken(
  //         Endpoints.getMilkCollection, params, token);
  //     return GetMilkCollectionModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<UploadStatusModel> getCollectionUploadStatusApi(params, token) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataJsonType(
  //         Endpoints.getCollectionUploadStatus, params, token);
  //     return UploadStatusModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }

  // Future<Response> postFATBasedManualRate(params, token) async {
  //   try {
  //     final response = await smartTrackApi.loadPostDataJsonType(
  //         Endpoints.postFatBasedManualRate, params, token);
  //     return response;
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     if (errorMessage == "Bad request") {
  //       await StorageService().clearData();
  //       gets.Get.offAllNamed(Routes.login);
  //     }
  //     throw errorMessage;
  //   }
  // }
}
