import 'package:benzy_test/src/controllers/candidate_reports_controller/candidate_reports_controller.dart';
import 'package:get/get.dart';

void initialBinding() {
  Get.lazyPut<CandidateReportsController>(
    () => CandidateReportsController(),
  );
}
