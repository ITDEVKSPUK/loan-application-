  // import 'package:flutter/material.dart';
  // import 'package:get/get.dart';
  // import 'package:loan_application/views/inputuserdata/formcontroller.dart';
  // import 'package:loan_application/views/inputuserdata/kamera_screen.dart';

  // void showImageSourcePicker(BuildContext context, bool isKtp) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) {
  //       return Wrap(
  //         children: [
  //           ListTile(
  //             leading: Icon(Icons.camera_alt),
  //             title: Text('Kamera'),
  //             onTap: () {
  //               Get.back();
  //               Get.to(() => CameraScreen(
  //                 onCapture: (path) {
  //                   final controller = Get.find<InputDataController>();
  //                   controller.setImageFromCamera(path, isKtp);
  //                 },
  //               ));
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.photo),
  //             title: Text('Galeri'),
  //             onTap: () {
  //               final controller = Get.find<InputDataController>();
  //               controller.pickImageFromGallery(isKtp);
  //               Get.back();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
