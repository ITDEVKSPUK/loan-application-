import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';
import 'package:loan_application/widgets/textfield_form.dart';

class FullCreditFormPage extends StatefulWidget {
  const FullCreditFormPage({super.key});

  @override
  State<FullCreditFormPage> createState() => _FullCreditFormPageState();
}

class _FullCreditFormPageState extends State<FullCreditFormPage> {
  final controller = CreditFormController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        appBar: AppBar(
          title: const Text("Form Pengajuan Kredit"),
          backgroundColor: AppColors.pureWhite,
          shadowColor: AppColors.pureWhite,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text("📝 Tujuan Kredit & Jaminan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: controller.selectedPurpose,
                decoration: const InputDecoration(labelText: "Tujuan Kredit"),
                items: ['MODAL KERJA', 'INVESTASI', 'KONSUMTIF']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) =>
                    setState(() => controller.selectedPurpose = val!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: controller.selectedCollateralType,
                decoration: const InputDecoration(labelText: "Jenis Jaminan"),
                items: ['Mobil', 'Motor', 'Tanah', 'Lainnya']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) =>
                    setState(() => controller.selectedCollateralType = val!),
              ),
              TextfieldForm(
                label: 'Jumlah yang akan dipinjam',
                hintText: 'Masukkan jumlah pinjaman',
                controller: controller.plafondController,
                keyboardType: TextInputType.number,
                inputFormatter: MoneyInputFormatter(),
              ),
              const SizedBox(height: 16),
              TextfieldForm(
                label: 'Deskripsi Jaminan',
                hintText: 'Contoh: BPKB',
                controller: controller.collateralDescriptionController,
              ),
              TextfieldForm(
                label: 'Nilai Jaminan',
                hintText: 'Masukkan nilai jaminan',
                controller: controller.collateralValueController,
                keyboardType: TextInputType.number,
                inputFormatter: MoneyInputFormatter(),
              ),
              const SizedBox(height: 24),
              const Text("📊 Info Keuangan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextfieldForm(
                label: 'Pendapatan per bulan',
                controller: controller.incomeController,
                keyboardType: TextInputType.number,
                inputFormatter: MoneyInputFormatter(),
              ),
              TextfieldForm(
                label: 'Total Aset',
                controller: controller.assetController,
                keyboardType: TextInputType.number,
                inputFormatter: MoneyInputFormatter(),
              ),
              TextfieldForm(
                label: 'Pengeluaran per bulan',
                controller: controller.expensesController,
                keyboardType: TextInputType.number,
                inputFormatter: MoneyInputFormatter(),
              ),
              TextfieldForm(
                label: 'Angsuran per bulan',
                controller: controller.installmentController,
                keyboardType: TextInputType.number,
                inputFormatter: MoneyInputFormatter(),
              ),
              const SizedBox(height: 24),
              const Text("📸 Foto Jaminan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.upload_file,
                        size: 40, color: Colors.grey.shade600),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await controller.pickImagesFromSource(context, () {
                          setState(() {}); // This will rebuild your widget
                        });
                      },
                      icon: const Icon(Icons.add_photo_alternate),
                      label: const Text("Upload Gambar Jaminan"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    if (controller.selectedImages.isEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        "Belum ada gambar yang dipilih",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.selectedImages
                    .map((img) => Image.file(File(img.path),
                        width: 80, height: 80, fit: BoxFit.cover))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () => controller.handleSubmit(context),
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
