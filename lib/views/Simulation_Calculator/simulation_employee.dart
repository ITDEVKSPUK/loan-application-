import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/Simulation_Calculator/loan_summary.dart';
import 'package:loan_application/views/Simulation_Calculator/simulation_controller.dart';
import 'package:loan_application/widgets/app_button.dart';
import 'package:loan_application/widgets/simulation calculator/loan_input_form.dart';
import 'package:loan_application/widgets/simulation calculator/loan_start_date_picker.dart';
import 'package:loan_application/widgets/simulation calculator/loan_type_dropdown.dart';

class Simulation_Employe extends StatelessWidget {
  const Simulation_Employe({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SimulationController());

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 57,
            color: Colors.white,
            child: const Center(
              child: Text(
                'Simulasi Kredit',
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoanInputForm(),
                  const SizedBox(height: 12),
                  LoanTypeDropdown(),
                  LoanStartDatePicker(startDate: controller.startDate),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Hitung',
                    onPressed: () => controller.calculateLoan(context),
                    color: AppColors.deepBlue,
                    borderRadius: 8,
                    paddingHorizontal: 16,
                    paddingVertical: 12,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 👇 Obx diletakkan DI DALAM scrollable column
                  Obx(() {
                    if (controller.response.value != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "Hasil Simulasi:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Batasin tinggi maksimal agar tombol tetap kelihatan
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.6,
                            ),
                            child: SingleChildScrollView(
                              child: LoanSummaryAndSchedule(
                                method: controller.method.value,
                                annualInterestRate:
                                    controller.annualInterestRate.value,
                                duration: controller.duration.value,
                                loanDate: controller.loanDate.value,
                                firstPaymentDue:
                                    controller.firstPaymentDue.value,
                                lastPaymentDue: controller.lastPaymentDue.value,
                                monthlyPayment: controller.monthlyPayment.value,
                                totalInterest: controller.totalInterest.value,
                                totalPayment: controller.totalPayment.value,
                                loanAmountText: controller.LoanAmount.value,
                                loanTermText:
                                    controller.loanTermController.text,
                                loanType: controller.loanType.value,
                                interestRateText:
                                    controller.interestRateController.text,
                                startDate: controller.startDate.value,
                                repaymentSchedule: controller.repaymentSchedule,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),

                  const SizedBox(
                      height: 32), // Jarak bawah biar ga terlalu mepet
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
