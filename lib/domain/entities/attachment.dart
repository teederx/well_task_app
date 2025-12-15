import 'package:equatable/equatable.dart';

enum AttachmentType { image, document, other }

class Attachment extends Equatable {
  final String id;
  final String fileName;
  final String filePath;
  final AttachmentType fileType;
  final int fileSize;
  final DateTime uploadedAt;

  const Attachment({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.uploadedAt,
  });

  Attachment copyWith({
    String? id,
    String? fileName,
    String? filePath,
    AttachmentType? fileType,
    int? fileSize,
    DateTime? uploadedAt,
  }) {
    return Attachment(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    fileName,
    filePath,
    fileType,
    fileSize,
    uploadedAt,
  ];
}


