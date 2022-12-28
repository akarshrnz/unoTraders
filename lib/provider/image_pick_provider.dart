import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickProvider with ChangeNotifier {
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<File> imageFile = [];

  pickImage() async {
    final  pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      images.add(pickImage);
       imageFile.add(File(pickImage.path));
       notifyListeners();
        // ignore: avoid_print
        print(images.length.toString());
    } else {}
   
   notifyListeners();
  }
  remove(int index){
    images.removeAt(index);
    imageFile.removeAt(index);
    notifyListeners();
  }
  clearImage(){
   images = [];
 imageFile = [];
  notifyListeners();

  }initialValues(){
   images = [];
 imageFile = [];
 

  }
   pickProfileImage() async {
     clearImage();
    final  pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      images.add(pickImage);
       imageFile.add(File(pickImage.path));
       notifyListeners();
        // ignore: avoid_print
        print(images.length.toString());
    } else {}
   
   notifyListeners();
  }

}
