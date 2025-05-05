import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loan_application/API/service/get_docagun.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class CreditFormController extends GetxController {
  final plafondController = TextEditingController();
  final purposeController = TextEditingController();
  final collateralDescriptionController = TextEditingController();
  final collateralValueController = TextEditingController();
  final incomeController = TextEditingController();
  final assetController = TextEditingController();
  final expensesController = TextEditingController();
  final installmentController = TextEditingController();

  // // Selected options
  // String selectedPurpose = 'MODAL KERJA';
  // String selectedCollateralType = 'Mobil';

  // Selected images for the PDF
  List<XFile> selectedImages = [];

  // Agunan and Document data
  var agunanList = <dynamic>[].obs;
  var documentList = <dynamic>[].obs;
  var selectedAgunan = ''.obs;
  var selectedDocument = ''.obs;

  Future<void> fetchAgunan() async {
    try {
      var fetchedAgunan = await getDocAgun.fetchAgunan();
      if (fetchedAgunan.isNotEmpty) {
        agunanList.value = fetchedAgunan;
      }
    } catch (e) {
      print("Error fetching agunan: $e");
    }
  }

  Future<void> fetchDocuments() async {
    try {
      var fetchedDocuments = await getDocAgun.fetchDocuments();
      if (fetchedDocuments.isNotEmpty) {
        documentList.value = fetchedDocuments;
      }
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAgunan();
    fetchDocuments();
  }

  // Picking images (from camera or gallery)
  Future<void> pickImagesFromSource(
      BuildContext context, VoidCallback onImagesUpdated) async {
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
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);
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

  // Generate PDF from selected images
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

  // Dispose controllers
  void dispose() {
    plafondController.dispose();
    collateralDescriptionController.dispose();
    collateralValueController.dispose();
    incomeController.dispose();
    assetController.dispose();
    expensesController.dispose();
    installmentController.dispose();
  }

  // Convert form data to JSON for submission
  Map<String, dynamic> toJson() {
    String cleanNumber(String text) => text.replaceAll(RegExp(r'[^0-9]'), '');

    return {
      "application": {
        "plafond": cleanNumber(plafondController.text),
      },
      "collateral": {
        "adddescript": selectedAgunan.value,
        "type": selectedDocument.value,
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

  // Handle form submission
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

var selectedAgunanImages = <File>[].obs;
var selectedDocumentImages = <File>[].obs;

Future<void> pickAgunanImages(BuildContext context) async {
  final source = await _chooseSource(context);
  if (source == null) return;

  if (source == ImageSource.gallery) {
    final result = await ImagePicker().pickMultiImage();
    if (result.isNotEmpty) {
      selectedAgunanImages.addAll(result.map((e) => File(e.path)));
    }
  } else {
    final single = await ImagePicker().pickImage(source: source);
    if (single != null) selectedAgunanImages.add(File(single.path));
  }
}

Future<void> pickDocumentImages(BuildContext context) async {
  final source = await _chooseSource(context);
  if (source == null) return;

  if (source == ImageSource.gallery) {
    final result = await ImagePicker().pickMultiImage();
    if (result.isNotEmpty) {
      selectedDocumentImages.addAll(result.map((e) => File(e.path)));
    }
  } else {
    final single = await ImagePicker().pickImage(source: source);
    if (single != null) selectedDocumentImages.add(File(single.path));
  }
}

Future<ImageSource?> _chooseSource(BuildContext context) async {
  return showModalBottomSheet<ImageSource>(
    context: context,
    builder: (ctx) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Galeri'),
          onTap: () => Navigator.pop(ctx, ImageSource.gallery),
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Kamera'),
          onTap: () => Navigator.pop(ctx, ImageSource.camera),
        ),
      ],
    ),
  );
}


}
