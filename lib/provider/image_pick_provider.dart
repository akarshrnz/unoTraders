import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';

class ImagePickProvider with ChangeNotifier {
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<File> imageFile = [];

  pickImage() async {
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      images.add(pickImage);
      imageFile.add(File(pickImage.path));
      notifyListeners();
      // ignore: avoid_print
      print(images.length.toString());
    } else {}

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
