// import 'package:benzy_test/network/response/api_response.dart';
// import 'package:flutter/material.dart';

// typedef NotifierBuilder<T> = Widget Function(T state);

// class BaseView<T> extends StatelessWidget {
//   final NotifierBuilder<T?> onData;
//   final Widget Function(String? error)? onError;
//   final Widget? onLoading;
//   final Future<ApiResponse<T>>? future;
//   const BaseView(
//       {Key? key,
//       required this.onData,
//       this.onError,
//       this.onLoading,
//       required this.future})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ApiResponse<T>>(
//       future: future,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           switch (snapshot.data?.status) {
//             case Status.LOADING:
//               return onLoading ??
//                   const Center(
//                     child: CircularProgressIndicator(),
//                   );

//             case Status.COMPLETED:
//               return onData(snapshot.data?.data);
//             case Status.ERROR:
//               return onError != null
//                   ? onError!(snapshot.data?.message)
//                   : Center(
//                       child: Text(
//                           snapshot.data?.message ?? "Something went wrong"),
//                     );

//             default:
//               return const SizedBox.shrink();
//           }
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
