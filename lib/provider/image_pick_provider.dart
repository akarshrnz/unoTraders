import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';

import 'package:permission_handler/permission_handler.dart';

class ImagePickProvider with ChangeNotifier {
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<File> imageFile = [];

  pickImage() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      PermissionStatus galleryPermissionStatus =
          await Permission.photos.request();
      if (galleryPermissionStatus.isGranted) {
        final pickImage =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickImage != null) {
          images.add(pickImage);
          imageFile.add(File(pickImage.path));
          notifyListeners();
          // ignore: avoid_print
          print(images.length.toString());
        } else {}
      } else if (galleryPermissionStatus.isDenied) {
        galleryPermissionStatus = await Permission.photos.request();
      } else {
        openAppSettings();
      }
    } else {
      var cameraPermissionStatus = await Permission.storage.request();
      if (cameraPermissionStatus.isGranted) {
        final pickImage =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickImage != null) {
          images.add(pickImage);
          imageFile.add(File(pickImage.path));
          notifyListeners();
          // ignore: avoid_print
          print(images.length.toString());
        } else {}
      } else if (cameraPermissionStatus.isDenied) {
        cameraPermissionStatus = await Permission.storage.request();
      } else {
        openAppSettings();
      }
    }
    // final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    // if (pickImage != null) {
    //   images.add(pickImage);
    //   imageFile.add(File(pickImage.path));
    //   notifyListeners();
    //   // ignore: avoid_print
    //   print(images.length.toString());
    // } else {
    // AppConstant.toastMsg(
    //     msg: "Something Went Wrong", backgroundColor: AppColor.red);
    // }

    notifyListeners();
  }

  pickImageFromCamera() async {
    var cameraPermissionStatus = await Permission.camera.request();
    if (cameraPermissionStatus.isGranted) {
      final pickImage = await imagePicker.pickImage(source: ImageSource.camera);
      if (pickImage != null) {
        images.add(pickImage);
        imageFile.add(File(pickImage.path));
        notifyListeners();
        // ignore: avoid_print
        print(images.length.toString());
      } else {}
    } else if (cameraPermissionStatus.isDenied) {
      cameraPermissionStatus = await Permission.camera.request();
    } else {
      openAppSettings();
    }

    // final pickImage = await imagePicker.pickImage(source: ImageSource.camera);
    // if (pickImage != null) {
    //   images.add(pickImage);
    //   imageFile.add(File(pickImage.path));
    //   notifyListeners();
    //   // ignore: avoid_print
    //   print(images.length.toString());
    // } else {}

    notifyListeners();
  }

  remove(int index) {
    images.removeAt(index);
    imageFile.removeAt(index);
    notifyListeners();
  }

  removeImage(int index) {
    imageFile.removeAt(index);
    notifyListeners();
  }

  clearImage() {
    images = [];
    imageFile = [];
    notifyListeners();
  }

  initialValues() {
    images = [];
    imageFile = [];
  }

  pickProfileImage() async {
    clearImage();
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      images.add(pickImage);
      imageFile.add(File(pickImage.path));
      print(File(pickImage.path));
      notifyListeners();
      // ignore: avoid_print
      print(images.length.toString());
    } else {}

    notifyListeners();
  }

  Future<void> networkImageToFile(List<String>? imageUrl) async {
    if (imageUrl == null) {
      return;
    } else {
      for (var url in imageUrl) {
        // generate random number.
        var rng = Random();
// get temporary directory of device.
        Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
        String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
        File file = File('$tempPath' + (rng.nextInt(100)).toString() + '.jpg');
// call http.get method and pass imageUrl into it to get response.
        http.Response response = await http.get(Uri.parse(url));
// write bodyBytes received in response to file.
        await file.writeAsBytes(response.bodyBytes);

        imageFile.add(file);
        print(file);

// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
      }
    }
    notifyListeners();
  }
}
