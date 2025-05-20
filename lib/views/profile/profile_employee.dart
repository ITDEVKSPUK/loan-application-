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
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBlue,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 57,
            child: const Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: AppColors.pureWhite,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.lightBlue,
                          child: Image.asset(
                            'assets/images/logo_ksp.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Obx(() => CustomText(
                              text: _profileController.userName.value,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            )),
                        const SizedBox(height: 6),
                        Obx(() {
                          final login = _profileController.loginName.value;
                          return login.isNotEmpty
                              ? CustomText(
                                  text: "Login ID: $login",
                                  fontSize: 16,
                                  fontFamily: 'Outfit',
                                )
                              : const SizedBox.shrink();
                        }),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Info User',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              const Divider(thickness: 1),
                              const SizedBox(height: 10),
                              Obx(() {
                                final group =
                                    _profileController.groupName.value;
                                return group.isNotEmpty
                                    ? _buildInfoRow("Group", group)
                                    : const SizedBox.shrink();
                              }),
                              const SizedBox(height: 10),
                              Obx(() {
                                final legal =
                                    _profileController.legalName.value;
                                return legal.isNotEmpty
                                    ? _buildInfoRow("Institusi", legal)
                                    : _buildInfoRow("Institusi", "test");
                              }),
                              const SizedBox(height: 10),
                              Obx(() {
                                final status =
                                    _profileController.status.value;
                                return status.isNotEmpty
                                    ? _buildInfoRow("Status", status)
                                    : const SizedBox.shrink();
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          text: 'Log Out',
                          onPressed: () {
                            LoginService().logout();
                            Get.offAllNamed(MyAppRoutes.loginScreen);
                          },
                          color: AppColors.lightBlue,
                          borderRadius: 15,
                          textStyle: const TextStyle(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit',
                          ),
                          paddingVertical: 15,
                          paddingHorizontal: 50,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
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
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Outfit',
            ),
          ),
        ),
      ],
    );
  }
}
