import 'package:flutter/material.dart';
import 'package:loan_application/core/theme/color.dart';

class NotificationBox extends StatelessWidget {
  final String name;
  final String status;
  final String date;
  final Color statusColor;

  const NotificationBox({
    super.key,
    required this.name,
    required this.status,
    required this.date,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon pesan
          Icon(Icons.message_outlined, color: statusColor, size: 22),
          const SizedBox(width: 10),

          // Nama & Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Tanggal
          Text(
            date,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
