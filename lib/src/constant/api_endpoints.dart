import '../../config/base_url_config.dart';

class ApiEndpoints {
  BaseUrlConfig apiBaseUrlModel = BaseUrlConfig();

  late String apiBaseUrl = apiBaseUrlModel.baseUrlProduction;

  late String customerReportEndPoints = "${apiBaseUrl}customer/report";
}
