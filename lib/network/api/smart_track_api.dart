import 'package:dio/dio.dart';
import 'package:get/get.dart' as gets;

import '../../common/utils/storage_service.dart';
import '../../common/utils/utility.dart';
import '../../routes/app_pages.dart';
import '../dio/dio_client.dart';

class SmartTrackApi {
  final DioClient dioClient;
  final storageService = StorageService();

  SmartTrackApi({required this.dioClient});

  Future<Response> loadPostFormData(endpoint, body, params, token) async {
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    dio.options.headers["Content-Type"] = "multipart/form-data";
    dio.options.headers["x-access-token"] = token;

    try {
      final Response response = await dioClient.post(endpoint,
          data: body,
          queryParameters: params,
          options: Options(contentType: 'multipart/form-data'));

      Map<String, dynamic> data = response.data;
      //print(response.data);
      if (data['show'] == true) {
        await Utils.showToast(data["message"]);
      }
      if (data['statusCode'] == 400) {
        //   await storageService.clearData();
        //    Get.offAllNamed(Routes.loginonboardscreen);
      }
      /*  if(response.statusCode.toString()=="401")
        {
          g.Get.offNamedUntil(Routes.login, (route) => false);
          storageService.setBool(AppConstants.isLoggedIn, false);
        }*/
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadGetData(endpoint, token) async {
    try {
      final Map<String, dynamic> header = new Map<String, dynamic>();
      header["x-access-token"] = token;
      final Response response = await dioClient.get(endpoint,
          options: Options(contentType: 'application/json', headers: header));
      Map<String, dynamic> data = response.data;
      return response; //json.encode(response);"
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadGetDataWithParams(endpoint, params, token) async {
    try {
      final Map<String, dynamic> header = new Map<String, dynamic>();
      header["x-access-token"] = token;
      final Response response = await dioClient.get(endpoint,
          queryParameters: params, options: Options(headers: header));
      Map<String, dynamic> data = response.data;

      if (data['statusCode'] == 400) {
        await storageService.clearData();
        gets.Get.offAllNamed(Routes.login);
      }
      //Map<String, dynamic> data = response.data;
      // print(response.data);
      /*  if (data['show'] == true) {
        await Utils.showToast(data["message"]);
      }
      if (data?['statusCode'] == 401) {
        //    await storageService.clearData();
        // Get.offAllNamed(Routes.loginonboardscreen);
      }*/
      /* if(response.statusCode.toString()=="401")
      {
        g.Get.offNamedUntil(Routes.login, (route) => false);
        storageService.setBool(AppConstants.isLoggedIn, false);
      }*/
      return response; //json.encode(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadGetDataWithOutParams(endpoint, token) async {
    try {
      Dio dio = new Dio();
      dio.options.headers["x-access-token"] = token;
      final Map<String, dynamic> header = new Map<String, dynamic>();
      header["token"] = token;

      final Response response =
          await dioClient.get(endpoint, options: Options(headers: header));
      Map<String, dynamic> data = response.data;
      // print(response.data);
      if (data['show'] == true) {
        await Utils.showToast(data["message"]);
      }

      if (data['statusCode'] == 400) {
        await storageService.clearData();
        gets.Get.offAllNamed(Routes.login);
      }
      /* if(response.statusCode.toString()=="401")
      {
        g.Get.offNamedUntil(Routes.login, (route) => false);
        storageService.setBool(AppConstants.isLoggedIn, false);
      }*/
      return response; //json.encode(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadPostDataToken(endpoint, params, token) async {
    final Map<String, dynamic> header = new Map<String, dynamic>();
    header["x-access-token"] = token;

    try {
      final Response response = await dioClient.post(endpoint,
          data: params,
          options: Options(headers: header, contentType: 'application/json'));

      Map<String, dynamic> data = response.data;

      if (data['statusCode'] == 400) {
        // await storageService.clearData();
        // gets.Get.offAllNamed(Routes.login);
      }
      
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadPostData(endpoint, params) async {
    try {
      final Response response = await dioClient.post(endpoint,
          data: params, options: Options(contentType: 'application/json'));

      Map<String, dynamic> data = response.data;

      if (data['statusCode'] == 400) {
        // await storageService.clearData();
        // gets.Get.offAllNamed(Routes.login);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadPostDataJsonType(endpoint, params, token) async {
    final Map<String, dynamic> header = new Map<String, dynamic>();
    header["x-access-token"] = token;

    try {
      final Response response = await dioClient.post(endpoint,
          data: params,
          options: Options(
            headers: header,
            contentType: 'application/json',
          ));

      Map<String, dynamic> data = response.data;

      if (data['statusCode'] == 400) {
        await storageService.clearData();
        gets.Get.offAllNamed(Routes.login);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadGetDataWithParamsJsonType(
      endpoint, params, token) async {
    try {
      final Map<String, dynamic> header = new Map<String, dynamic>();
      header["token"] = token;
      final Response response = await dioClient.get(
        endpoint,
        queryParameters: params,
        options: Options(headers: header),
      );
      Map<String, dynamic> data = response.data;
      // print(response.data);
      if (data['show'] == true) {
        await Utils.showToast(data["message"]);
      }

      if (data['statusCode'] == 400) {
        await storageService.clearData();
        gets.Get.offAllNamed(Routes.login);
      }
      /* if(response.statusCode.toString()=="401")
      {
        g.Get.offNamedUntil(Routes.login, (route) => false);
        storageService.setBool(AppConstants.isLoggedIn, false);
      }*/
      return response; //json.encode(response);
    } catch (e) {
      rethrow;
    }
  }
}
