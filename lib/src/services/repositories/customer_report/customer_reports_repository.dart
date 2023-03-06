import 'dart:developer';

import 'package:benzy_test/src/constant/api_endpoints.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../models/customer_reports_model/customer_reports_model.dart';
import '../../../../network/api/api_manager.dart';

class CustomerReportsRepository {
  final _apiManager = ApiManager();

  Future<Either<Failure, CustomerReportsResponseModel>>
      getCandidateProfileStats(dynamic params) async {
    try {
      var jsonResponse = await _apiManager.post(
          ApiEndpoints().customerReportEndPoints, params);
      log(jsonResponse.toString());
      var response = CustomerReportsResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message ?? ""));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }
}
