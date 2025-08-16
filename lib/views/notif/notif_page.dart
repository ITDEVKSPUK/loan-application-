import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/home/home_controller.dart';
import 'package:loan_application/widgets/survey_box.dart';

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
          // Filter hanya yang status.read == "notif"
          final notifList = controller.surveyList
              .where((item) => item.status?.read == "notif")
              .toList();

          if (notifList.isEmpty) {
            return const Center(child: Text('Tidak ada notifikasi baru'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: notifList.length,
            itemBuilder: (context, index) {
              final item = notifList[index];
              final statusText =
                  item.status?.value ?? item.application.toString();
              final statusColor = controller.getStatusColor(statusText);

              return GestureDetector(
                onTap: () => Get.toNamed(
                  MyAppRoutes.detailanggota,
                  arguments: item,
                ),
                child: Stack(
                  children: [
                    SurveyBox(
                      name: item.fullName,
                      date: DateFormat('yyyy-MMMM-dd', 'id_ID')
                          .format(item.application.trxDate),
                      location: item.sectorCity,
                      image: (item.document?.docPerson.isNotEmpty ?? false)
                          ? item.document!.docPerson[0].img
                          : 'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png',
                      status: statusText,
                      statusColor: statusColor,
                      plafond: item.application.plafond,
                      aged: item.aged,
                      trxSurvey: item.application.trxSurvey.toString(),
                    ),
                    // Titik merah indikator belum dibaca
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
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
