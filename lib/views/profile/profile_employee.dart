import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/service/post_login.dart';
import 'package:loan_application/views/profile/profile_controller.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/widgets/app_button.dart';
import 'package:loan_application/widgets/custom_text.dart';

class ProfileEmployee extends StatefulWidget {
  const ProfileEmployee({super.key});

  @override
  State<ProfileEmployee> createState() => _ProfileEmployeeState();
}

class _ProfileEmployeeState extends State<ProfileEmployee> {
  // Inisialisasi controller
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBlue,
      appBar: AppBar(
        backgroundColor: AppColors.softBlue,
        elevation: 0,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 180),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: AppColors.pureWhite,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 120),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.lightBlue,
                  child: Image.asset(
                    'assets/images/logo_ksp.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 24),
                // Username
                Obx(() => CustomText(
                  text: _profileController.userName.value,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                )),
                SizedBox(height: 6),
                // Login Name
                Obx(() {
                  final login = _profileController.loginName.value;
                  return login.isNotEmpty
                    ? CustomText(
                        text: "Login ID: $login",
                        fontSize: 16,
                        fontFamily: 'Outfit',
                      )
                    : SizedBox.shrink();
                }),
                SizedBox(height: 24),
                // Info Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Info User',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 10),
                      // Group Info
                      Obx(() {
                        final group = _profileController.groupName.value;
                        return group.isNotEmpty
                          ? _buildInfoRow("Group", group)
                          : SizedBox.shrink();
                      }),
                      SizedBox(height: 10),
                      // Legal Name
                      Obx(() {
                        final legal = _profileController.legalName.value;
                        return legal.isNotEmpty
                          ? _buildInfoRow("Institusi", legal)
                          : _buildInfoRow("Institusi", "test");
                      }),
                      SizedBox(height: 10),
                      // Status
                      Obx(() {
                        final status = _profileController.status.value;
                        return status.isNotEmpty
                          ? _buildInfoRow("Status", status)
                          : SizedBox.shrink();
                      }),
                    ],
                  ),
                ),
                Spacer(),
                CustomButton(
                  text: 'Log Out',
                  onPressed: () {
                    LoginService().logout();
                    Get.offAllNamed(MyAppRoutes.loginScreen);
                  },
                  color: AppColors.lightBlue,
                  borderRadius: 15,
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit',
                  ),
                  paddingVertical: 15,
                  paddingHorizontal: 50,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Outfit',
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Outfit',
          ),
        ),
      ],
    );
  }
}