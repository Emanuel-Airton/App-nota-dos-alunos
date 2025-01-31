import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/profile/services/image_profile_firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfileController {
  Future image() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      final img = File(image!.path);
      ImageProfileFirebaseStorage().uploadImageFirebaseStorage(image);
      return img;
    } catch (e) {
      debugPrint("erro: $e");
    }
  }
}
