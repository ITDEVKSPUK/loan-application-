import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';

class FilterButtons extends StatelessWidget {
  final Function(String) onFilterSelected;

  const FilterButtons({required this.onFilterSelected, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 10)),
          SizedBox(
            width: 109,
            child: ElevatedButton(
              onPressed: () => onFilterSelected('ACCEPTED'),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.black,
                backgroundColor: AppColors.pureWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text('ACCEPTED', style: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 109,
            child: ElevatedButton(
              onPressed: () => onFilterSelected('DECLINED'),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.black,
                backgroundColor: AppColors.pureWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text('DECLINED', style: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 109,
            child: ElevatedButton(
              onPressed: () => onFilterSelected('UNREAD'),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.black,
                backgroundColor: AppColors.pureWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text('UNREAD', style: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 109,
            child: ElevatedButton(
              onPressed: () => onFilterSelected('LOCATION'),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.black,
                backgroundColor: AppColors.pureWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text('LOCATION', style: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 109,
            child: ElevatedButton(
              onPressed: () => onFilterSelected('DATE'),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.black,
                backgroundColor: AppColors.pureWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text('DATE', style: TextStyle(fontSize: 12)),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
        ],
      ),
    );
  }
}
