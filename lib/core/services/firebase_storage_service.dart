import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageService {
  Future<String> uploadProfilePicture(File file, {firebasePath});
}

class FirebaseStorageService extends StorageService {
  @override
  Future<String> uploadProfilePicture(File file, {firebasePath}) async {
    try {
      final uploadTask = firebasePath.putFile(
          file, SettableMetadata(contentType: 'image/png'));
      await uploadTask.whenComplete(() => null);

      // Url used to download file/image
      final downloadUrl = await (await uploadTask).ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('error uploading avatar to storage: ' + e.toString());
      return null;
    }
  }
}
