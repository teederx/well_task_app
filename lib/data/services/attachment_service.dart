import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:well_task_app/data/models/attachment_model/attachment_model.dart';

class AttachmentService {
  final ImagePicker _picker = ImagePicker();
  final Uuid _uuid = const Uuid();

  Future<AttachmentModel?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return null;

      final File file = File(image.path);
      return await _saveFileToAppDir(file, AttachmentType.image);
    } catch (e) {
      return null;
    }
  }

  Future<AttachmentModel?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null || result.files.single.path == null) return null;

      final File file = File(result.files.single.path!);
      return await _saveFileToAppDir(file, AttachmentType.document);
    } catch (e) {
      return null;
    }
  }

  Future<AttachmentModel> _saveFileToAppDir(
    File file,
    AttachmentType type,
  ) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(file.path);
    final savedFile = await file.copy('${appDir.path}/$fileName');

    return AttachmentModel(
      id: _uuid.v4(),
      fileName: fileName,
      filePath: savedFile.path,
      fileType: type,
      fileSize: await savedFile.length(),
      uploadedAt: DateTime.now(),
    );
  }

  Future<void> deleteAttachment(AttachmentModel attachment) async {
    final file = File(attachment.filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
