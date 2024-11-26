import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/documents_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/file_document_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_add_file_button.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_submit_button.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_text_field.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_documents_dto.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/student/presentation/components/form/field/file_documents_list.dart';
import 'package:my_profile_microfrontend/app/student/presentation/components/sheet/file_bottom_sheet.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/validation/cpf_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/email_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class DocumentsForm extends StatefulWidget {
  const DocumentsForm({
    super.key,
    required this.documentsEntity,
    required this.spaceBetweenFields,
    required this.myProfileEntity,
  });

  static final _formKey = GlobalKey<FormState>();
  final DocumentsEntity? documentsEntity;
  final double spaceBetweenFields;
  final MyProfileEntity? myProfileEntity;

  @override
  State<DocumentsForm> createState() => _DocumentsFormState();
}

class _DocumentsFormState extends State<DocumentsForm>
    with ValidationMixin, EmailValidationMixin, CpfValidationMixin {
  late final MaskedTextController _cpfController;
  late final TextEditingController _rgController;
  late final TextEditingController _nisController;
  late final TextEditingController _nifController;
  late final TextEditingController _birthCertificateController;
  final List<int> _filesToDelete = [];

  final Translation translation = Modular.get<Translation>();
  final StudentProfileBloc profileBloc = Modular.get<StudentProfileBloc>();

  @override
  void initState() {
    _cpfController = MaskedTextController(
      mask: '000.000.000-00',
      text: widget.documentsEntity?.cpf,
    );
    _rgController = TextEditingController(
      text: widget.documentsEntity?.rg ?? '',
    );
    _nisController = TextEditingController(
      text: widget.documentsEntity?.nis,
    );
    _nifController = TextEditingController(
      text: widget.documentsEntity?.nif,
    );
    _birthCertificateController = TextEditingController(
      text: widget.documentsEntity?.birthCertificate,
    );
    super.initState();
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _rgController.dispose();
    _nisController.dispose();
    _nifController.dispose();
    _birthCertificateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Form(
        key: DocumentsForm._formKey,
        child: Column(
          children: [
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'docNumberInput'),
              controller: _cpfController,
              validator: (value) {
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label:
                  translation.translate(package: 'my_profile', key: 'rgInput'),
              controller: _rgController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label:
                  translation.translate(package: 'my_profile', key: 'nisInput'),
              controller: _nisController,
              validator: (value) {
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label:
                  translation.translate(package: 'my_profile', key: 'nifInput'),
              keyboardType: TextInputType.number,
              validator: (value) {
                return null;
              },
              controller: _nifController,
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'birthCertificateInput'),
              validator: (value) {
                return null;
              },
              controller: _birthCertificateController,
            ),
            FileDocumentsList(
              documents: widget.documentsEntity?.documents ?? [],
              onDelete: (document) {
                setState(() {
                  widget.documentsEntity?.documents.remove(document);
                });

                if (document.id == null) {
                  return;
                }

                if (!_filesToDelete.contains(document.id)) {
                  _filesToDelete.add(document.id!);
                }
              },
            ),
            SizedBox(height: widget.spaceBetweenFields * 1.5),
            ProfileAddFileButton(
              label:
                  translation.translate(package: 'my_profile', key: 'addFile'),
              onPressed: () => openFileModal(),
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileSubmitButton(
              label: translation.translate(
                  package: 'my_profile', key: 'submitButton'),
              actionLabel: translation.translate(
                  package: 'my_profile', key: 'submitButtonAction'),
              onSubmit: submitForm,
            ),
          ],
        ),
      ),
    );
  }

  void submitForm() {
    if (!DocumentsForm._formKey.currentState!.validate()) {
      return;
    }

    var documents = widget.documentsEntity?.documents.where((document) {
      return document.id == null;
    }).toList();

    final updateDto = UpdateDocumentsDto(
      cpf: _cpfController.text,
      rg: _rgController.text,
      nis: _nisController.text,
      nif: _nifController.text,
      birthCertificate: _birthCertificateController.text,
      files: documents ?? [],
      filesToDelete: _filesToDelete,
    );

    profileBloc.add(UpdateStudentProfile(
      dataTransferObject: updateDto,
      studentId: widget.myProfileEntity?.studentId,
    ));
  }

  void openFileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: FileBottomSheet(onSubmit: addNewFile),
        );
      },
    );
  }

  void addNewFile(
      PlatformFile? newFile, String description, String observation) {
    if (newFile == null) {
      showFileError();
      return;
    }

    File file = File(newFile.path!);
    List<int> fileBytes = file.readAsBytesSync();
    String base64File = base64Encode(fileBytes);

    if (base64File.isEmpty) {
      showFileError();
      return;
    }

    var fileEntity = FileDocumentEntity(
      fileBase64: base64File,
      description: description,
      observation: observation,
    );

    setState(() {
      widget.documentsEntity?.documents.add(fileEntity);
    });

    Navigator.pop(context);
  }

  void showFileError() {
    Navigator.pop(context);
    showErrorDialog(
      context: context,
      title: translation.translate(
          package: 'my_profile', key: 'addFileErrorTitle'),
      contentText:
          translation.translate(package: 'my_profile', key: 'addFileErrorText'),
    );
  }
}
