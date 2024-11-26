class FileDocumentEntity {
  final int? id;
  final String? description;
  final String? observation;
  final String? fileUrl;
  final String? fileBase64;

  FileDocumentEntity({
    this.id,
    this.description,
    this.observation,
    this.fileUrl,
    this.fileBase64,
  });

  factory FileDocumentEntity.fromJson(Map<String, dynamic> json) {
    return FileDocumentEntity(
      id: json['id'],
      description: json['description'],
      observation: json['observations'],
      fileUrl: json['file_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'file': fileBase64,
      'observations': observation,
    };
  }
}
