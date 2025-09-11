import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';

class KtpCameraScreen extends StatefulWidget {
  final CreditFormController controller;
  KtpCameraScreen({super.key, required this.controller});

  @override
  _KtpCameraScreenState createState() => _KtpCameraScreenState();
}

class _KtpCameraScreenState extends State<KtpCameraScreen> {
  @override
  void initState() {
    super.initState();
    print('KtpCameraScreen: Menginisialisasi kamera');
    widget.controller.initializeCamera();
  }

  @override
  void dispose() {
    print('KtpCameraScreen: Membuang kamera');
    widget.controller.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pindai KTP')),
      body: Obx(() {
        if (widget.controller.isCameraInitialized.value) {
          print('KtpCameraScreen: Menampilkan preview kamera');
          return Stack(
            alignment: Alignment.center,
            children: [
              widget.controller.cameraPreview.value,
              Container(
                width: 300,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.whitegray, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Posisikan KTP di sini',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: widget.controller.isProcessing.value
                      ? null
                      : () async {
                          try {
                            await widget.controller.scanKTP(context);
                          } catch (e) {}
                        },
                  backgroundColor: widget.controller.isProcessing.value
                      ? Colors.grey
                      : Colors.white,
                  child: widget.controller.isProcessing.value
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 4),
                          ),
                        ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
