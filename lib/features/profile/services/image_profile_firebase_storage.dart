import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfileFirebaseStorage {
  uploadImageFirebaseStorage(XFile image) async {
    String _imagePath = '';
    debugPrint('nome da imagem: ${image.name}');

    final imageFile = await image.readAsBytes();
    final ref = FirebaseStorage.instance.ref();
    final child = ref.child('images/${image.name}');
    final uploadTask = child.putData(imageFile);
    uploadTask.snapshotEvents.listen((event) async {
      if (event.state == TaskState.success) {
        _imagePath = await event.ref.getDownloadURL();
        debugPrint('upload feito com sucesso: $_imagePath');
      } else if (event.state == TaskState.error) {
        debugPrint('Erro ao salvar image: ${TaskState.error.toString()}');

        // handle error case
      }
    });
  }
}
