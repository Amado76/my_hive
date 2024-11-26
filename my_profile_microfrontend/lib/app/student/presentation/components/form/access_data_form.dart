import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_password_field.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_phone_field.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_submit_button.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_access_data_dto.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_text_field.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/validation/cpf_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/email_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class AccessDataForm extends StatefulWidget {
  const AccessDataForm(
      {super.key,
      required this.spaceBetweenFields,
      required this.entity,
      required this.isoCode});

  final double spaceBetweenFields;
  final MyProfileEntity? entity;
  final String? isoCode;

  set entity(MyProfileEntity? entity) {
    entity = entity;
  }

  @override
  State<AccessDataForm> createState() => _AccessDataFormState();
}

class _AccessDataFormState extends State<AccessDataForm>
    with ValidationMixin, EmailValidationMixin, CpfValidationMixin {
  static final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  final Translation translation = Modular.get<Translation>();
  final StudentProfileBloc profileBloc = Modular.get<StudentProfileBloc>();

  @override
  void initState() {
    _emailController = TextEditingController(text: widget.entity?.email);
    _phoneController = TextEditingController(
      text: widget.entity?.formattedPhoneNumber,
    );
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Form(
        key: _AccessDataFormState._formKey,
        child: Column(
          children: [
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'emailInput'),
              controller: _emailController,
              validator: (email) {
                return combine([
                  () => isNotNull(email),
                  () => isNotEmpty(email),
                  () => isValidEmail(email!),
                ]);
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfilePhoneField(
              isoCode: widget.isoCode,
              label: translation.translate(
                  package: 'my_profile', key: 'phoneNumberInput'),
              controller: _phoneController,
              validator: (phone) {
                return combine([
                  () => isNotNull(phone),
                  () => isNotEmpty(phone),
                ]);
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            const Divider(),
            SizedBox(height: widget.spaceBetweenFields),
            Text(
              translation.translate(
                  package: 'my_profile', key: 'changePasswordTip'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfilePasswordField(
              label: translation.translate(
                  package: 'my_profile', key: "newPasswordInput"),
              controller: _newPasswordController,
              validator: (password) {
                return combine([
                  () => hasMinLength(password, 6),
                ]);
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfilePasswordField(
              label: translation.translate(
                  package: 'my_profile', key: "confirmPasswordInput"),
              controller: _confirmPasswordController,
              validator: (password) {
                return combine([
                  () => isEqualTo(
                      password,
                      _newPasswordController.text,
                      translation.translate(
                        package: 'my_profile',
                        key: 'samePasswordValidation',
                      )),
                ]);
              },
            ),
            SizedBox(height: widget.spaceBetweenFields * 0.4),
            Text(
              "* ${translation.translate(key: 'passwordSafetyTip', package: 'my_profile')}",
              style: TextStyle(
                fontSize: 12,
                height: 1.1,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: widget.spaceBetweenFields * 1.5),
            ProfileSubmitButton(
              label: translation.translate(
                  package: 'my_profile', key: 'submitButton'),
              actionLabel: translation.translate(
                  package: 'my_profile', key: 'submitButtonAction'),
              onSubmit: submitForm,
            )
          ],
        ),
      ),
    );
  }

  void submitForm() {
    if (!_AccessDataFormState._formKey.currentState!.validate()) {
      return;
    }

    final updateDto = UpdateAccessDataDto(
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      newPassword: _newPasswordController.text,
      newPasswordConfirmation: _confirmPasswordController.text,
    );

    profileBloc.add(UpdateStudentProfile(
      dataTransferObject: updateDto,
      studentId: widget.entity!.studentId,
    ));
  }
}
