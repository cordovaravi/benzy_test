import 'package:flutter/material.dart';

import '../../../models/customer_reports_model/customer_reports_model.dart';

class UserListReportWidget extends StatelessWidget {
  final CustomerReportsResponseModel customerReportsResponseModel;
  const UserListReportWidget({
    Key? key,
    required this.customerReportsResponseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
            "User Name: ${customerReportsResponseModel.user?.fName} ${customerReportsResponseModel.user?.lName}"),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: customerReportsResponseModel.reports?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                    "At- ${customerReportsResponseModel.reports?[index].date}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Break fast : ${customerReportsResponseModel.reports?[index].optIns?.breakfast}"),
                    Text(
                        "Lunch : ${customerReportsResponseModel.reports?[index].optIns?.lunch}"),
                    Text(
                        "Dinner : ${customerReportsResponseModel.reports?[index].optIns?.dinner}"),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
