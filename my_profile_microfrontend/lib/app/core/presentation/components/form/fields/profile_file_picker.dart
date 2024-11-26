// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/util/my_profile_error.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ProfileFilePicker extends StatefulWidget {
  ProfileFilePicker({
    super.key,
    required this.fileNotifier,
    this.controller,
    this.labelController,
    this.validator,
  });

  final TextEditingController? controller;
  final TextEditingController? labelController;
  final String? Function(String?)? validator;

  final ValueNotifier<PlatformFile?> fileNotifier;
  FilePickerResult? selectedFile;

  @override
  State<ProfileFilePicker> createState() => _ProfileFilePickerState();
}

class _ProfileFilePickerState extends State<ProfileFilePicker> {
  final formFieldKey = GlobalKey<FormFieldState>();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return FormField(
        key: formFieldKey,
        validator: widget.validator,
        builder: (FormFieldState<dynamic> state) {
          return Column(
            children: [
              GestureDetector(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: !state.hasError ? Colors.grey[350]! : Colors.red,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.labelController!.text,
                          style:
                              TextStyle(color: Colors.grey[600]!, fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.upload_file,
                        color: !state.hasError ? Colors.grey[600]! : Colors.red,
                      ),
                    ],
                  ),
                ),
                onTap: () =>
                    _showImageSourceActionSheet(imagePicker: _imagePicker),
              ),
              Visibility(
                visible: state.hasError,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    state.errorText != null ? state.errorText! : '',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void addFile() async {
    // Infelizmente o FilePicker tem uma incompatibilidade com o teclado aberto, por isso precisamos fechá-lo e aguardar para que o processo seja concluído.
    // PS: Existe issue disso no Github.
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 400));
    FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg'],
    ).then((value) {
      widget.selectedFile = value;
      if (widget.selectedFile == null) {
        return;
      }
      setState(() {
        widget.labelController!.text = widget.selectedFile!.files.single.name;
        widget.controller?.text = widget.selectedFile!.files.single.path!;
        widget.fileNotifier.value = widget.selectedFile!.files.single;
        formFieldKey.currentState?.didChange(widget.controller?.text);
        formFieldKey.currentState?.validate();
      });
    }, onError: (error) {});
  }

  void _showImageSourceActionSheet({required ImagePicker imagePicker}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              title: const Text('Choose from documents'),
              onTap: () {
                Navigator.of(context).pop();
                addFile();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        PlatformFile test = widget.fileNotifier.value = PlatformFile(
          size: 0,
          name: pickedFile.path,
          path: pickedFile.path,
        );
        setState(() {
          widget.labelController!.text = pickedFile.path;
          widget.controller?.text = pickedFile.path;
          widget.fileNotifier.value = test;
          formFieldKey.currentState?.didChange(widget.controller?.text);
          formFieldKey.currentState?.validate();
        });
      }
    } catch (e) {
      if (e is MyProfileError) {
        _showPermissionErrorDialog();
      }
    }
  }

  Future<void> _showPermissionErrorDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
            'You need to grant permission to access the camera or gallery.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
