import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_file_picker.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_text_field.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class FileBottomSheet extends StatefulWidget {
  const FileBottomSheet({super.key, required this.onSubmit});

  final Function onSubmit;

  @override
  State<FileBottomSheet> createState() => _FileBottomSheetState();
}

class _FileBottomSheetState extends State<FileBottomSheet>
    with ValidationMixin {
  final Translation translation = Modular.get<Translation>();

  final TextEditingController _descriptionController = TextEditingController();
  late VoidCallback _textFieldListener;
  final TextEditingController _observationController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  late final TextEditingController _fileLabelController;
  final ValueNotifier<PlatformFile?> _selectedFileNotifier =
      ValueNotifier(null);

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fileLabelController = TextEditingController(
      text: translation.translate(package: 'my_profile', key: 'chooseFile'),
    );
    _descriptionController.addListener(_textFieldListener = () {
      setState(() {});
    });
    _observationController.addListener(_textFieldListener = () {
      setState(() => {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _selectedFileNotifier.dispose();
    _fileLabelController.dispose();
    _fileController.dispose();
    _descriptionController.removeListener(_textFieldListener);
    _observationController.removeListener(_textFieldListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 5, right: 5),
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      translation.translate(
                          package: 'my_profile', key: 'fileModalTip'),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ProfileFilePicker(
                      controller: _fileController,
                      labelController: _fileLabelController,
                      fileNotifier: _selectedFileNotifier,
                      validator: (value) {
                        return combine([
                          () => isNotNull(value),
                          () => isNotEmpty(value),
                        ]);
                      },
                    ),
                    const SizedBox(height: 20),
                    ProfileTextField(
                      label: translation.translate(
                          package: 'my_profile',
                          key: 'documentDescriptionInput'),
                      controller: _descriptionController,
                      validator: (value) {
                        return combine([
                          () => isNotNull(value),
                          () => isNotEmpty(value),
                        ]);
                      },
                    ),
                    const SizedBox(height: 20),
                    ProfileTextField(
                      label: translation.translate(
                          package: 'my_profile',
                          key: 'documentObservationInput'),
                      controller: _observationController,
                      validator: (value) {
                        return combine([
                          () => isNotNull(value),
                          () => isNotEmpty(value),
                        ]);
                      },
                    ),
                    const SizedBox(height: 20),
                    FileModalSubmitButton(
                      onSubmit: widget.onSubmit,
                      formKey: formKey,
                      fileNotifier: _selectedFileNotifier,
                      description: _descriptionController.text,
                      observation: _observationController.text,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}

class FileModalSubmitButton extends StatelessWidget {
  FileModalSubmitButton({
    super.key,
    required this.onSubmit,
    required this.formKey,
    required this.fileNotifier,
    required this.description,
    required this.observation,
  });

  final Function onSubmit;
  final ValueNotifier<PlatformFile?> fileNotifier;
  final String description;
  final String observation;

  final Translation translation = Modular.get<Translation>();
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return ElevatedButton(
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        }

        onSubmit(fileNotifier.value, description, observation);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        translation
            .translate(package: 'my_profile', key: 'addFile')
            .toUpperCase(),
        style: TextStyle(color: themeMode!.textColor),
      ),
    );
  }
}
