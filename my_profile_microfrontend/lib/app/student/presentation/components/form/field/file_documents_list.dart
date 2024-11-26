import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/file_document_entity.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class FileDocumentsList extends StatefulWidget {
  const FileDocumentsList({
    super.key,
    required this.documents,
    required this.onDelete,
  });

  final List<FileDocumentEntity> documents;
  final void Function(FileDocumentEntity) onDelete;

  @override
  State<FileDocumentsList> createState() => _FileDocumentsListState();
}

class _FileDocumentsListState extends State<FileDocumentsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.documents.isNotEmpty,
          child: const SizedBox(height: 20),
        ),
        Visibility(
          visible: widget.documents.isNotEmpty,
          child: const Divider(),
        ),
        Visibility(
          visible: widget.documents.isNotEmpty,
          child: const SizedBox(height: 20),
        ),
        for (final document in widget.documents)
          Column(
            children: [
              if (widget.documents.indexOf(document) != 0)
                const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FileDocument(document: document),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => widget.onDelete(document),
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey[600],
                      size: 35,
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

class FileDocument extends StatelessWidget {
  FileDocument({
    super.key,
    required this.document,
  });

  final FileDocumentEntity document;
  final Translation translation = Modular.get<Translation>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[350]!,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey[350]!,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                document.description ?? '',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () async {
                if (document.fileUrl == null) {
                  return;
                }

                final url = Uri.parse(document.fileUrl!);

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  if (context.mounted) {
                    showLaunchUrlErrorDialog(context);
                  }
                }
              },
              child: Icon(
                  document.fileUrl != null
                      ? Icons.download
                      : Icons.file_download_off_outlined,
                  color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  void showLaunchUrlErrorDialog(context) {
    showErrorDialog(
      context: context,
      title: translation.translate(
          package: 'my_profile', key: 'launchUrlErrorTitle'),
      contentText: translation.translate(
          package: 'my_profile', key: 'launchUrlErrorTitle'),
    );
  }
}
