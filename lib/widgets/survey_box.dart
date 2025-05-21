import 'package:flutter/material.dart';
import 'package:loan_application/core/theme/color.dart';

class SurveyBox extends StatelessWidget {
  final String name;
  final String aged;
  final String plafond;
  final String date;
  final String location;
  final String trx_survey;
  final String status;
  final String image;
  final Color statusColor;

  const SurveyBox({
    super.key,
    required this.name,
    required this.aged,
    required this.plafond,
    required this.date,
    required this.trx_survey,
    required this.location,
    required this.status,
    required this.image,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = image.startsWith('http');

    return Container(
      height: 120, // tinggi ditambah agar tidak overflow
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Container(
              width: 100,
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

          // Konten utama
          Flexible(
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
                  buildInfoRow(Icons.calendar_today, date),
                  buildInfoRow(Icons.person, aged),
                  buildInfoRow(Icons.account_balance, plafond),
                  buildInfoRow(Icons.assignment, trx_survey),
                  buildInfoRow(Icons.location_on, location),
                ],
              ),
            ),
          ),

          // Status box
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
