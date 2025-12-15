import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:well_task_app/domain/entities/attachment.dart';

part 'attachment_model.freezed.dart';
part 'attachment_model.g.dart';

@freezed
abstract class AttachmentModel with _$AttachmentModel {
  @JsonSerializable(explicitToJson: true)
  const factory AttachmentModel({
    required String id,
    required String fileName,
    required String filePath,
    required AttachmentType fileType,
    required int fileSize,
    required DateTime uploadedAt,
  }) = _AttachmentModel;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);
}
