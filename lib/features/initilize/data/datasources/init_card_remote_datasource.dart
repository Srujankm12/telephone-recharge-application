// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:telephone_recharge_application/core/constants/routes.dart';

// abstract interface class InitCardRemoteDatasource {
//   Future<bool> checkInternetConnection();
//   Future<String> deductAmountFromDatabase({
//     required String collegeId,
//     required String machineId,
//     required String userId,
//     required String amount,
//   });
// }

// class InitCardRemoteDatasourceImpl implements InitCardRemoteDatasource {
//   final http.Client client;
//   final InternetConnection connection;
//   InitCardRemoteDatasourceImpl({
//     required this.client,
//     required this.connection,
//   });
//   @override
//   Future<String> deductAmountFromDatabase({
//     required String collegeId,
//     required String machineId,
//     required String userId,
//     required String amount,
//   }) async {
//     try {
//       final response = await client.post(
//         Uri.parse("${Routes.deductAmount}/"),
//         body: jsonEncode({
//           "college_id":"",
//           "machine_id":"",
//           "user_id":"",
//           "amount":
//         }),
//         headers: {"Content-Type": "application/json"},
//       );
//     } catch (e) {
//       throw e;
//     }
//   }

//   @override
//   Future<bool> checkInternetConnection() async {
//     return await connection.hasInternetAccess;
//   }
// }
