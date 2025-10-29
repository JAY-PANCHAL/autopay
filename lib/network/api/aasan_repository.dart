// import 'package:dio/dio.dart';
// import 'package:get/get.dart' as gets;
// import 'package:smart_track/network/model/location_model.dart';
// import '../../common/utils/storage_service.dart';
// import '../../routes/app_pages.dart';
// import '../constant/endpoints.dart';
// import '../dio/dio_exception.dart';
// import '../model/FatBasedRateChartCountModel.dart';
// import '../model/bank_master_model.dart';
// import '../model/data_related_setting_model.dart';
// import '../model/fat_based_rate_chart.dart';
// import '../model/get_asan_app_menu.dart';
// import '../model/get_milk_collection_model.dart';
// import '../model/last_local_sales_id.dart';
// import '../model/max_auto_id.dart';
// import '../model/max_of_member_code.dart';
// import '../model/member_count_api.dart';
// import '../model/location_insert_model.dart';
// import '../model/member_data_model.dart';
// import '../model/post_collection_model.dart';
// import '../model/rate_related_setting_model.dart';
// import '../model/session_related_setting.dart';
// import '../model/token_model.dart';
// import '../model/upload_status_model.dart';
// import '../model/verify_otp_model.dart';
// import 'aasan_api.dart';

// class AasanRepository {
//   final AsaanApi asaanApi;
//   final storageService = StorageService();

//   AasanRepository(this.asaanApi);

//   Future<OtpModel> login(params) async {
//     try {
//       final response =
//           await asaanApi.loadPostDataJsonType(Endpoints.login, params, null);
//       //return ConfigModel.fromJson(response.data);
//       return OtpModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<VerifyOtpModel> verifyOTP(params) async {
//     try {
//       final response = await asaanApi.loadPostDataJsonType(
//           Endpoints.verifyOtp, params, null);
//       return VerifyOtpModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<GetMemberCountResponse> getMemberCount(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getMemberCount, token);
//       return GetMemberCountResponse.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<MemberDataModel> getMemberData(token, params) async {
//     try {
//       final response =
//           await asaanApi.loadPostData(Endpoints.getMemberData, params, token);
//       return MemberDataModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<LocationModel> getlocationMaster(params) async {
//     try {
//       final response = await asaanApi.loadGetDataWithParams(
//           Endpoints.locationMaster, params, "");
//       return LocationModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<LocationInsertModel> getlocationInsert(params) async {
//     try {
//       final response =
//           await asaanApi.loadPostData(Endpoints.locationInsert, params, "");
//       return LocationInsertModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<dynamic> confirmMemberData(token, params) async {
//     try {
//       final response = await asaanApi.loadPostData(
//           Endpoints.confirmMemberData, params, token);
//       return response.data;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<MaxOfMemberCode> getMaxOfMemberCode(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.maxofMembers, token);
//       return MaxOfMemberCode.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<LstLocalSalesIDModel> getLastLocalSalesIDApi(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getLastLocalsalesID, token);
//       return LstLocalSalesIDModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<LstLocalSalesIDModel> getLastpayDeductionIDApi(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getLastPayDeductionID, token);
//       return LstLocalSalesIDModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<BankMasterModel> getBankMasterApi(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getBankMaster, token);
//       return BankMasterModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<DataRelatedSettingsModel> getDataRelatedSettingApi(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getDataRelatedSetting, token);
//       return DataRelatedSettingsModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<SessionSettingsModel> getSessionRelatedSettingApi(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getSessionRelatedSetting, token);
//       return SessionSettingsModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<RateRelatedSettingsModel> getRateRelatedSettingApi(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getRateRelatedSetting, token);
//       return RateRelatedSettingsModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<FatBasedRateChartCountModel> getFATBasedRateChartCountApi(
//       token) async {
//     try {
//       final response = await asaanApi.loadGetData(
//           Endpoints.getFATBasedRateChartCount, token);
//       return FatBasedRateChartCountModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<FatBasedRateChartModel> getFATBasedRateChartApi(token, params) async {
//     try {
//       final response = await asaanApi.loadPostData(
//           Endpoints.getFATBasedRateChart, params, token);
//       return FatBasedRateChartModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<FatBasedRateChartModel> confirmFATBasedRateChartApi(
//       token, params) async {
//     try {
//       final response = await asaanApi.loadPostData(
//           Endpoints.confirmFATBasedRateChart, params, token);
//       return FatBasedRateChartModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<GetAsaanAppMenu> getAsanAppMenuApi(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getAsaanAppMenu, token);
//       return GetAsaanAppMenu.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<dynamic> getConfirmNotificaion(token, endpoint) async {
//     try {
//       final response = await asaanApi.loadGetData(endpoint, token);
//       return response.data;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   /*Future<GetAsaanAppMenu>getAsanAppUserRoleApi(token) async {
//     try {
//       final response =
//       await asaanApi.loadGetData(Endpoints.getAsaanAppMenu,token);
//       return GetAsaanAppMenu.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//        if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }*/

//   Future<MaxAutoID> getlastCollectionID(token) async {
//     try {
//       final response =
//           await asaanApi.loadGetData(Endpoints.getLastCollectionId, token);
//       return MaxAutoID.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<PostMilkCollectionModel> postMilkCollection(params, token) async {
//     try {
//       final response = await asaanApi.loadPostDataJsonType(
//           Endpoints.postMilkCollection, params, token);
//       return PostMilkCollectionModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<GetMilkCollectionModel> getMilkCollection(token, params) async {
//     try {
//       final response = await asaanApi.loadPostData(
//           Endpoints.getMilkCollection, params, token);
//       return GetMilkCollectionModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<UploadStatusModel> getCollectionUploadStatusApi(params, token) async {
//     try {
//       final response = await asaanApi.loadPostDataJsonType(
//           Endpoints.getCollectionUploadStatus, params, token);
//       return UploadStatusModel.fromJson(response.data);
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }

//   Future<Response> postFATBasedManualRate(params, token) async {
//     try {
//       final response = await asaanApi.loadPostDataJsonType(
//           Endpoints.postFatBasedManualRate, params, token);
//       return response;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "Bad request") {
//         await StorageService().clearData();
//         gets.Get.offAllNamed(Routes.login);
//       }
//       throw errorMessage;
//     }
//   }
// }
