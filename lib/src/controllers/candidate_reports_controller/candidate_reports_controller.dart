import 'dart:convert';

import 'package:benzy_test/network/response/api_response.dart';
import 'package:benzy_test/src/models/customer_reports_model/customer_reports_model.dart';
import 'package:benzy_test/src/services/repositories/customer_report/customer_reports_repository.dart';
import 'package:get/get.dart';

class CandidateReportsController extends GetxController {
  final CustomerReportsRepository _customerReportsRepository =
      CustomerReportsRepository();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final Rx<CustomerReportsResponseModel> _customerReportsReponse =
      CustomerReportsResponseModel().obs;

  CustomerReportsResponseModel get customerReportsResponseModel =>
      _customerReportsReponse.value;

  getCustomerReport(int selectedMonth) async {
    _isLoading(true);
    String params = json.encode({"month": selectedMonth});
    var response =
        await _customerReportsRepository.getCandidateProfileStats(params);

    response.fold((failure) {
      _isLoading(false);
      return ApiResponse.error(failure.message);
    }, (data) {
      _customerReportsReponse.value.reports?.clear();
      _customerReportsReponse.value = data;
      _isLoading(false);
      getFoodWastedCharges();
      return ApiResponse.completed(data);
    });
  }

  int? getFoodWastedCharges() {
    int chargers = 0;
    if (_customerReportsReponse.value.reports?.isEmpty ?? true) {
      return null;
    }
    _customerReportsReponse.value.reports?.forEach((day) {
      if (day.optIns?.breakfast == FoodStatus.PENDING) {
        chargers += 100;
      }
      if (day.optIns?.dinner == FoodStatus.PENDING) {
        chargers += 100;
      }
      if (day.optIns?.lunch == FoodStatus.PENDING) {
        chargers += 100;
      }
    });
    return chargers;
  }
}
