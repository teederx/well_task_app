// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    _AttachmentModel(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
      fileType: $enumDecode(_$AttachmentTypeEnumMap, json['fileType']),
      fileSize: (json['fileSize'] as num).toInt(),
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );

Map<String, dynamic> _$AttachmentModelToJson(_AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'filePath': instance.filePath,
      'fileType': _$AttachmentTypeEnumMap[instance.fileType]!,
      'fileSize': instance.fileSize,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
    };

const _$AttachmentTypeEnumMap = {
  AttachmentType.image: 'image',
  AttachmentType.document: 'document',
  AttachmentType.other: 'other',
};


