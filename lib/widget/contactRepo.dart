// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ContactRepository {
//   final Dio _dio = Dio();
//
//   Future<void> sendContactNumber({
//     required String number,
//     required String type, // "call" or "sms"
//   }) async {
//     // Get token from SharedPreferences
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("auth_token") ?? "";
//
//     // Body to send
//     final body = {
//       "number": number,
//       "type": type,
//     };
//
//     try {
//       final response = await _dio.post(
//         "http://192.168.1.16:7001/api/driver/send_number",
//         data: body,
//         options: Options(
//           headers: {
//             "Content-Type": "application/json",
//             "Authorization": "Bearer $token",
//           },
//           validateStatus: (status) => true, // allow all status codes
//         ),
//       );
//       print("Status: ${response.statusCode}");
//       print("Body: ${response.data}");
//
//     } on DioException catch (e) {
//       if (e.response != null) {
//         // The server responded with error code (like 400, 405, etc.)
//         print("Error sending number: ${e.response?.statusCode} ${e.response?.data}");
//       } else {
//         // Something happened in sending the request
//         print("Error sending number: ${e.message}");
//       }
//     } catch (e) {
//       print("Unexpected error: $e");
//     }
//   }
// }
