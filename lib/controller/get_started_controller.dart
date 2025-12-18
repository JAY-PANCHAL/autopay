import 'dart:convert';

import 'package:autopay/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/utils/app_constants.dart';
import '../common/utils/utility.dart';
import '../network/model/country_model.dart';

class GetStartedController extends BaseController {

  void saveCountriesToStorage(List<Countries> countries) {
    final jsonList = countries.map((e) => e.toJson()).toList();
    storageService.setString(
      AppConstants.countriespr,
      jsonEncode(jsonList),
    );
  }

@override
  void onInit() {
   countryApiCall();

    super.onInit();
  }
  Future<void> countryApiCall() async {
       isLoading.value = true;

    var token=await storageService.getString(AppConstants.tokenPr);

    await repo.countryApiCall(token).then((value) async {
      isLoading.value = false;
      if (value.success == 1 && value.data?.countries != null) {
        saveCountriesToStorage(value.data!.countries!);
        // ✅ Success case
        Utils.showToast(value.data!.message ?? "Counties fetched successfully");
      } else {
        // ❌ API responded but failed
        Utils.showToast(
          value.data?.message ?? "Countries fetch failed. Please try again.",
        );
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Utils.showToast(error.toString());
    });

  }
}
