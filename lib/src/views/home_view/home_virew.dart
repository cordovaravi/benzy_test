// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/candidate_reports_controller/candidate_reports_controller.dart';
import 'components/show_bottom_sheet.dart';
import 'components/user_list_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CandidateReportsController _candidateReportsController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _candidateReportsController.getCustomerReport(1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Food report"),
        ),
        floatingActionButton: FloatingActionButton.small(
            child: const Icon(Icons.article),
            onPressed: () {
              if (_candidateReportsController
                      .customerReportsResponseModel.reports?.isNotEmpty ??
                  false) {
                showChargesBottomSheet(context,
                    charges:
                        _candidateReportsController.getFoodWastedCharges());
              }
            }),
        body: Obx(() {
          if (_candidateReportsController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_candidateReportsController
                  .customerReportsResponseModel.reports?.isNotEmpty ??
              false) {
            return UserListReportWidget(
                customerReportsResponseModel:
                    _candidateReportsController.customerReportsResponseModel);
          }
          return const SizedBox.shrink();
        }));
  }
}
