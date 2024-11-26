import 'package:my_profile_microfrontend/app/core/domain/entities/file_document_entity.dart';

class DocumentsEntity {
  final String? cpf;
  final String? rg;
  final String? nif;
  final String? nis;
  final String? birthCertificate;
  final List<FileDocumentEntity> documents;

  DocumentsEntity({
    this.cpf,
    this.rg,
    this.nif,
    this.nis,
    this.birthCertificate,
    this.documents = const [],
  });

  factory DocumentsEntity.fromJson(Map<String, dynamic> json) {
    return DocumentsEntity(
      cpf: json['cpf'],
      rg: json['rg'],
      nif: json['nif'],
      nis: json['nis'],
      birthCertificate: json['birth_certificate'],
      documents: json['documents'] != null
          ? (json['documents'] as List)
              .map((e) => FileDocumentEntity.fromJson(e))
              .toList()
          : [],
    );
  }
}
