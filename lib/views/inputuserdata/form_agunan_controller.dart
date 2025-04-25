import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class CreditFormController {
  final plafondController = TextEditingController();
  final collateralDescriptionController = TextEditingController();
  final collateralValueController = TextEditingController();
  final incomeController = TextEditingController();
  final assetController = TextEditingController();
  final expensesController = TextEditingController();
  final installmentController = TextEditingController();

  String selectedPurpose = 'MODAL KERJA';
  String selectedCollateralType = 'Mobil';

  List<XFile> selectedImages = [];

Future<void> pickImagesFromSource(BuildContext context, VoidCallback onImagesUpdated) async {
  final picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Ambil dari Kamera'),
            onTap: () async {
              Navigator.pop(context);
              final XFile? image = await picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                selectedImages.add(image);
                onImagesUpdated(); // Trigger UI update
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Pilih dari Galeri'),
            onTap: () async {
              Navigator.pop(context);
              final List<XFile>? images = await picker.pickMultiImage();
              if (images != null) {
                selectedImages.addAll(images);
                onImagesUpdated(); // Trigger UI update
              }
            },
          ),
        ],
      ),
    ),
  );
}



  Future<File> generatePdfFromImages() async {
    final pdf = pw.Document();
    for (var image in selectedImages) {
      final imageBytes = await image.readAsBytes();
      final pwImage = pw.MemoryImage(imageBytes);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Image(pwImage),
          ),
        ),
      );
    }

    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/jaminan_bukti.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  void dispose() {
    plafondController.dispose();
    collateralDescriptionController.dispose();
    collateralValueController.dispose();
    incomeController.dispose();
    assetController.dispose();
    expensesController.dispose();
    installmentController.dispose();
  }

  Map<String, dynamic> toJson() {
    String cleanNumber(String text) => text.replaceAll(RegExp(r'[^0-9]'), '');

    return {
      "application": {
        "plafond": cleanNumber(plafondController.text),
        "purpose": selectedPurpose,
      },
      "collateral": {
        "id_name": selectedCollateralType,
        "adddescript": collateralDescriptionController.text,
        "value": cleanNumber(collateralValueController.text),
      },
      "additionalinfo": {
        "income": cleanNumber(incomeController.text),
        "asset": cleanNumber(assetController.text),
        "expenses": cleanNumber(expensesController.text),
        "installment": cleanNumber(installmentController.text),
      },
    };
  }

  Future<void> handleSubmit(BuildContext context) async {
    final formData = toJson();
    print("DATA TERKIRIM:");
    print(formData);

    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap unggah gambar jaminan terlebih dahulu.")),
      );
      return;
    }

    final pdfFile = await generatePdfFromImages();
    print("PDF berhasil dibuat: ${pdfFile.path}");

   

    // TODO: Kirim ke API (data dan file)
  }
}
