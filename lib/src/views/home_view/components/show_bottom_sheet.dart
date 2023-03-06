import 'package:flutter/material.dart';

showChargesBottomSheet(BuildContext context, {int? charges}) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: const Text("The waste food charges of month 1 st are"),
            subtitle: Text("$charges rupees"),
          ),
        );
      },
      context: context);
}
