import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/views/employee/History/showfilterbuttom.dart';

class FilterButtons extends StatelessWidget {
  final Function(String) onFilterSelected;

  const FilterButtons({required this.onFilterSelected, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 310,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 15)),
                SizedBox(
                  width: 109,
                  child: ElevatedButton(
                    onPressed: () => onFilterSelected('ACCEPTED'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.black,
                      backgroundColor: AppColors.pureWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                        borderRadius: BorderRadius.circular(10),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('UNREAD', style: TextStyle(fontSize: 12)),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 5)),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showFilterBottomSheet(context, onFilterSelected);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.black,
            backgroundColor: AppColors.pureWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0,
          ),
          child: Icon(Icons.filter_list_alt,
              size: 25, color: AppColors.blackLight),
        ),
      ],
    );
  }
}
