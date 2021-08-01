import 'dart:io';
import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/viewmodel/base_model.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerModel extends BaseModel {
  String errorMsg;
  File pickedFile;
  Future<void> pickImage() async {
    setState(ViewState.Busy);
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      pickedFile = File(result.files.single.path);

      setState(ViewState.Idle);
    } else {
      errorMsg = 'Failed to pick file';
      setState(ViewState.Idle);
    }
  }
}
