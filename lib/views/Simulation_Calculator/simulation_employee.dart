import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/Simulation_Calculator/loan_summary.dart';
import 'package:loan_application/views/Simulation_Calculator/simulation_controller.dart';
import 'package:loan_application/widgets/app_button.dart';
import 'package:loan_application/widgets/loan_input_form.dart';
import 'package:loan_application/widgets/loan_start_date_picker.dart';
import 'package:loan_application/widgets/loan_type_dropdown.dart';

class Simulation_Employe extends StatelessWidget {
  const Simulation_Employe({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SimulationController());

    double calculateTotal(String key) {
      return controller.repaymentSchedule
          .fold(0.0, (sum, item) => sum + item[key]);
    }

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
                children: [
                  LoanInputForm(
                    loanAmountController: controller.loanAmountController,
                    loanTermController: controller.loanTermController,
                    interestRateController: controller.interestRateController,
                  ),
                  const SizedBox(height: 12),
                  LoanTypeDropdown(loanType: controller.loanType),
                  LoanStartDatePicker(startDate: controller.startDate),
                  CustomButton(
                    text: 'Hitung',
                    onPressed: () => controller.calculateLoan(context),
                    color: AppColors.deepBlue,
                    borderRadius: 8,
                    paddingHorizontal: BorderSide.strokeAlignCenter,
                    paddingVertical: BorderSide.strokeAlignCenter,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => controller.monthlyPayment.value > 0
                      ? LoanSummaryAndSchedule(
                          monthlyPayment: controller.monthlyPayment.value,
                          totalInterest: controller.totalInterest.value,
                          totalPayment: controller.totalPayment.value,
                          loanAmountText: controller.loanAmountController.text,
                          loanTermText: controller.loanTermController.text,
                          loanType: controller.loanType.value,
                          interestRateText:
                              controller.interestRateController.text,
                          startDate: controller.startDate.value,
                          repaymentSchedule: controller.repaymentSchedule,
                        )
                      : const SizedBox()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
