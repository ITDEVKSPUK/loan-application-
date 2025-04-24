import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  final Function(String) onCapture;

  const CameraScreen({super.key, required this.onCapture});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras.first,
      ResolutionPreset.high,
    );

    await _cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    try {
      final image = await _cameraController.takePicture();
      widget.onCapture(image.path);
      Get.back(); // Close the camera screen
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isCameraInitialized
          ? Stack(
              children: [
                // Background with black transparent opacity
                Container(
                  color:
                      Colors.black.withOpacity(0.10), // Black with transparency
                ),
                CameraPreview(_cameraController),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                // Capture Button
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _captureImage,
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),
                        backgroundColor: Colors.white,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
