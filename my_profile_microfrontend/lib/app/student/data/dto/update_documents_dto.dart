import 'package:my_profile_microfrontend/app/core/domain/entities/file_document_entity.dart';
import 'package:my_profile_microfrontend/app/student/domain/dto/student_dto.dart';

class UpdateDocumentsDto extends StudentDto {
  static const pageId = 4;

  final String? cpf;
  final String? rg;
  final String? nis;
  final String? nif;
  final String? birthCertificate;
  final List<FileDocumentEntity> files;
  final List<int> filesToDelete;

  UpdateDocumentsDto({
    required this.cpf,
    required this.rg,
    required this.nis,
    required this.nif,
    required this.birthCertificate,
    required this.files,
    required this.filesToDelete,
  });

  @override
  Map<String, dynamic> toJson() {
    var jsonData = {
      'page_id': pageId,
      'cpf': cpf,
      'rg': rg,
      'nis': nis,
      'nif': nif,
      'birth_certificate': birthCertificate,
      'documents': files.map((file) => file.toJson()).toList(),
      'files_to_delete': filesToDelete,
    };

    jsonData.removeWhere((_, value) => value == null);

    return jsonData;
  }
}
