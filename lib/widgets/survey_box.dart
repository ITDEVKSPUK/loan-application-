import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/home/note_popup.dart';

class SurveyBox extends StatelessWidget {
  final String name;
  final String aged;
  final String plafond;
  final String date;
  final String location;
  final String status;
  final String image;
  final Color statusColor;
  final String trxSurvey;

  const SurveyBox({
    super.key,
    required this.name,
    required this.aged,
    required this.plafond,
    required this.date,
    required this.location,
    required this.status,
    required this.image,
    required this.statusColor,
    required this.trxSurvey,
  });

  String formatRupiah(String numberString) {
    if (numberString.isEmpty || numberString == '0' || numberString == '0.00') {
      return 'Rp 0,00';
    }
    final number =
        double.tryParse(numberString.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    if (number == 0) return 'Rp 0,00';

    final formatted = number.toStringAsFixed(2);
    final parts = formatted.split('.');
    final integerPart = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
    return 'Rp $integerPart,${parts[1]}';
  }

  String formatAge(String ageString) {
    return ageString.replaceAll('years old', 'years').trim();
  }

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = image.startsWith('http');
    final formattedPlafond = formatRupiah(plafond);
    final formattedAge = formatAge(aged);

    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Container(
              width: 100,
              height: 120,
              color: Colors.grey[200],
              child: isNetworkImage
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    )
                  : Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  buildInfoRow(Icons.account_balance, formattedPlafond),
                  buildInfoRow(Icons.calendar_today, date),
                  buildInfoRow(Icons.person, formattedAge),
                  buildInfoRow(Icons.location_on, location),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 54, // Matches the status width to align properly
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                final controller = Get.put(InqurySurveyController());
                controller.getSurveyList(
                    trxSurvey:
                        trxSurvey);
                showDialog(
                  context: context,
                  builder: (context) => const NotePopup(),
                );
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              width: 54,
              color: statusColor,
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    status.isEmpty ? 'No Status' : status,
                    style: const TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: 14,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icon, color: AppColors.black, size: 12),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 10,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
