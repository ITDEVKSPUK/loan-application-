import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/home/home_controller.dart';
import 'package:loan_application/views/notif/notif_widget.dart';

class NotifPage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  NotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: RefreshIndicator(
        color: AppColors.black,
        backgroundColor: Colors.white,
        onRefresh: () async {
          await Future(() => controller.getHistory());
        },
        child: Obx(() {
          // Filter yang status.read == "notif" atau "read"
          final notifList = controller.surveyList
              .where((item) =>
                  item.status?.read == "notif" || item.status?.read == "read")
              .toList()
            ..sort((a, b) {
              // Urutkan berdasarkan status read: "notif" di atas, "read" di bawah
              if (a.status?.read == "notif" && b.status?.read == "read") {
                return -1; // a (notif) di atas b (read)
              } else if (a.status?.read == "read" &&
                  b.status?.read == "notif") {
                return 1; // b (notif) di atas a (read)
              } else {
                // Jika sama-sama notif atau sama-sama read, urutkan berdasarkan tanggal terbaru
                return b.application.trxDate.compareTo(a.application.trxDate);
              }
            });

          if (notifList.isEmpty) {
            return const Center(child: Text('Tidak ada notifikasi'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: notifList.length,
            itemBuilder: (context, index) {
              final item = notifList[index];
              final statusText =
                  item.status?.value ?? item.application.toString();
              final statusColor = controller.getStatusColor(statusText);
              final isUnread = item.status?.read == "notif";

              return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(
                      MyAppRoutes.detailanggota,
                      arguments: item,
                    ),
                    child: Stack(
                      children: [
                        // Container dengan styling berbeda untuk yang sudah dibaca
                        Container(
                          decoration: BoxDecoration(
                            // Background abu untuk yang sudah dibaca
                            color: isUnread ? Colors.white : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isUnread
                                  ? Colors.transparent
                                  : Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Opacity(
                            opacity: isUnread ? 1.0 : 0.7,
                            child: NotificationBox(
                              name: item.fullName,
                              date: DateFormat('dd-MMMM-yyyy', 'id_ID')
                                  .format(item.application.trxDate),
                              status: statusText,
                              statusColor:
                                  isUnread ? statusColor : Colors.grey[600]!,
                            ),
                          ),
                        ),
                        // Titik merah indikator hanya untuk yang belum dibaca
                        if (isUnread)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        // Ikon "sudah dibaca" untuk yang sudah dibaca
                        if (!isUnread)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.grey[400],
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  ));
            },
          );
        }),
      ),
    );
  }
}
