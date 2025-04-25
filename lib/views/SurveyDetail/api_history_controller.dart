// // lib/controllers/history_controller.dart
// import 'package:get/get.dart';
// import 'package:loan_application/API/service/post_history.dart';
// import '../../API/models/history_models.dart';

// class HistoryController extends GetxController {
//   RxList<Datum> historyData = <Datum>[].obs;

//   Future<void> fetchHistoryData({
//     required String officeId,
//     required DateTime fromDateTime,
//     required DateTime toDateTime,
//   }) async {
//     try {
//       // Panggil service untuk mengambil data dari API
//       final response = await HistoryService().fetchHistoryDebitur(
//         officeId: officeId,
//         fromDateTime: fromDateTime,
//         toDateTime: toDateTime,
//       );

//       // Parse data response menjadi model HistoryResponse
//       final historyResponse = HistoryResponse.fromJson(response.data);

//       // Set data ke dalam historyData
//       historyData.value = historyResponse.data;
//     } catch (e) {
//       print("Error fetching history data: $e");
//     }
//   }
// }
