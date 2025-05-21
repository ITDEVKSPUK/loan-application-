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
        children: [
          // Gambar
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
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
          // Informasi utama
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Di dalam Column(...) yang ada di child dari Expanded(...)
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
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: AppColors.black, size: 12),
                      const SizedBox(width: 5),
                      Text(
                        date,
                        style: TextStyle(
                          color: AppColors.black.withOpacity(0.6),
                          fontSize: 10,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person,
                          color: AppColors.black, size: 12),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          aged,
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.account_balance,
                          color: AppColors.black, size: 12),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          plafond,
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.assignment,
                          color: AppColors.black, size: 12),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          trx_survey,
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.black, size: 12),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          location,
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
                ],
              ),
            ),
          ),
          // Status
          Container(
            width: 54,
            height: 100,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
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
        ],
      ),
    );
  }
}
