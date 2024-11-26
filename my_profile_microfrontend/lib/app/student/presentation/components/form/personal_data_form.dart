import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_select_field.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_submit_button.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_personal_data_dto.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_avatar.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_text_field.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/validation/date_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class PersonalDataForm extends StatefulWidget {
  const PersonalDataForm(
      {super.key,
      required this.spaceBetweenFields,
      required this.profileEntity});

  static final _formKey = GlobalKey<FormState>();
  final double spaceBetweenFields;
  final MyProfileEntity? profileEntity;

  set profileEntity(MyProfileEntity? profileEntity) {
    profileEntity = profileEntity;
  }

  @override
  State<PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm>
    with ValidationMixin, DateValidationMixin {
  late final TextEditingController _nameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final MaskedTextController _birthdateController;
  late final TextEditingController _healthCarePlanController;
  late final TextEditingController _referenceHospitalController;
  late final TextEditingController _dominantSideController;
  late final TextEditingController _genderController;
  File? _avatar;

  final Translation translation = Modular.get<Translation>();
  final StudentProfileBloc profileBloc = Modular.get<StudentProfileBloc>();

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.profileEntity?.firstName);
    _lastNameController =
        TextEditingController(text: widget.profileEntity?.lastName);
    _heightController = MaskedTextController(
      mask: '0,00',
      text: widget.profileEntity?.formattedHeight,
    );
    // Precisa ser MoneyMaskedTextController para aceitar todas casas de peso (ex: 70.2, 133.5)...
    _weightController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      precision: 1,
      initialValue: widget.profileEntity?.weight,
    );
    _birthdateController = MaskedTextController(
      mask: '00/00/0000',
      text: widget.profileEntity?.birthdate,
    );
    _healthCarePlanController = TextEditingController(
      text: widget.profileEntity?.healthCarePlan,
    );
    _referenceHospitalController = TextEditingController(
      text: widget.profileEntity?.referenceHospital,
    );
    _dominantSideController = TextEditingController(
      text: widget.profileEntity?.foot,
    );
    _genderController = TextEditingController(
      text: widget.profileEntity?.gender,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _birthdateController.dispose();
    _healthCarePlanController.dispose();
    _referenceHospitalController.dispose();
    _dominantSideController.dispose();
    _genderController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileEntity = widget.profileEntity;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Form(
        key: PersonalDataForm._formKey,
        child: Column(
          children: [
            ProfileAvatar(
              avatarUrl: profileEntity?.avatarUrl,
              onChangeAvatar: (newAvatar) {
                _avatar = newAvatar;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'nameInput'),
              controller: _nameController,
              validator: (firstName) {
                return combine([
                  () => isNotNull(firstName),
                  () => isNotEmpty(firstName),
                ]);
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'lastNameInput'),
              controller: _lastNameController,
              validator: (lastName) {
                return combine([
                  () => isNotNull(lastName),
                  () => isNotEmpty(lastName),
                ]);
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'birthdateInput'),
              keyboardType: TextInputType.datetime,
              controller: _birthdateController,
              validator: (date) => isValidDate(date),
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileSelectField(
              label:
                  translation.translate(package: 'my_profile', key: 'gender'),
              hint: translation.translate(
                  package: 'my_profile', key: 'pickYourGender'),
              items: {
                'Masculino': translation.translate(
                    package: 'my_profile', key: 'maleGender'),
                'Feminino': translation.translate(
                    package: 'my_profile', key: 'femaleGender'),
                'Outros': translation.translate(
                    package: 'my_profile', key: 'otherGender'),
              },
              controller: _genderController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'heightInput'),
              controller: _heightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'weightInput'),
              controller: _weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileSelectField(
              label: translation.translate(
                  package: 'my_profile', key: 'dominantSide'),
              hint: translation.translate(
                  package: 'my_profile', key: 'pickYourDominantSide'),
              items: {
                'Destro': translation.translate(
                    package: 'my_profile', key: 'rightSide'),
                'Canhoto': translation.translate(
                    package: 'my_profile', key: 'leftSide'),
                'Ambidestro': translation.translate(
                    package: 'my_profile', key: 'bothSides'),
              },
              controller: _dominantSideController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'healthCarePlanInput'),
              controller: _healthCarePlanController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'referenceHospitalInput'),
              controller: _referenceHospitalController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields * 1.5),
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
    if (!PersonalDataForm._formKey.currentState!.validate()) {
      return;
    }

    final updateDto = UpdatePersonalDataDto(
      firstName: _nameController.text,
      lastName: _lastNameController.text,
      birthdate: _birthdateController.text,
      gender: _genderController.text,
      height: _heightController.text == ''
          ? null
          : double.parse(_heightController.text.replaceAll(',', '.')),
      weight: _heightController.text == ''
          ? null
          : double.parse(
              _weightController.text.replaceAll('.', '').replaceAll(',', '.')),
      dominantSide: _dominantSideController.text,
      healthCarePlan: _healthCarePlanController.text,
      referenceHospital: _referenceHospitalController.text,
      avatar: _avatar != null ? convertAvatarToBase64(_avatar!) : null,
    );

    profileBloc.add(UpdateStudentProfile(
      dataTransferObject: updateDto,
      studentId: widget.profileEntity?.studentId,
    ));
  }

  String convertAvatarToBase64(File avatar) {
    final bytes = avatar.readAsBytesSync();
    final base64 = base64Encode(bytes);
    return base64;
  }
}
