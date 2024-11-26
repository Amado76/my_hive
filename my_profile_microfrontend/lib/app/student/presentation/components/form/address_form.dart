import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/address_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/address_repository_interface.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_submit_button.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/form/fields/profile_text_field.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_address_dto.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/validation/cpf_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/email_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({
    super.key,
    required this.addressEntity,
    required this.spaceBetweenFields,
    required this.myProfileEntity,
  });

  static final _formKey = GlobalKey<FormState>();
  final AddressEntity? addressEntity;
  final double spaceBetweenFields;
  final MyProfileEntity? myProfileEntity;

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm>
    with ValidationMixin, EmailValidationMixin, CpfValidationMixin {
  late final TextEditingController _streetTypeController;
  late final TextEditingController _streetController;
  late final TextEditingController _numberController;
  late final TextEditingController _complementController;
  late final TextEditingController _districtController;
  late final MaskedTextController _cepController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;

  final Translation translation = Modular.get<Translation>();
  final StudentProfileBloc profileBloc = Modular.get<StudentProfileBloc>();

  @override
  void initState() {
    _streetTypeController = TextEditingController(
      text: widget.addressEntity?.streetType,
    );
    _streetController = TextEditingController(
      text: widget.addressEntity?.street,
    );
    _numberController = TextEditingController(
      text: widget.addressEntity?.number,
    );
    _complementController = TextEditingController(
      text: widget.addressEntity?.complement,
    );
    _districtController = TextEditingController(
      text: widget.addressEntity?.district,
    );
    _cepController = MaskedTextController(
      mask: '00000-000',
      text: widget.addressEntity?.postalCode,
    );
    _cityController = TextEditingController(
      text: widget.addressEntity?.city,
    );
    _stateController = TextEditingController(
      text: widget.addressEntity?.state,
    );
    super.initState();
  }

  @override
  void dispose() {
    _streetTypeController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _districtController.dispose();
    _cepController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Form(
        key: AddressForm._formKey,
        child: Column(
          children: [
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'postalCodeInput'),
              controller: _cepController,
              keyboardType: TextInputType.number,
              onChanged: (cep) => updateAddressByPostalCode(cep),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'streetTypeInput'),
              controller: _streetTypeController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'streetInput'),
              controller: _streetController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'numberInput'),
              controller: _numberController,
              keyboardType: TextInputType.number,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'complementInput'),
              controller: _complementController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'districtInput'),
              controller: _districtController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'cityInput'),
              controller: _cityController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: widget.spaceBetweenFields),
            ProfileTextField(
              label: translation.translate(
                  package: 'my_profile', key: 'stateInput'),
              controller: _stateController,
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
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateAddressByPostalCode(String? postalCode) async {
    if (postalCode == null || postalCode.length < 9) return;

    try {
      String formattedPostalCode = postalCode.replaceAll('-', '');
      AddressRepositoryInterface addressRepository =
          Modular.get<AddressRepositoryInterface>();

      var response = await addressRepository
          .getAddressBasedOnPostalCode(formattedPostalCode);

      _streetController.text = response['logradouro'];
      _districtController.text = response['bairro'];
      _cityController.text = response['localidade'];
      _stateController.text = response['uf'];
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void submitForm() {
    if (!AddressForm._formKey.currentState!.validate()) {
      return;
    }

    final updateDto = UpdateAddressDto(
      streetType: _streetTypeController.text,
      street: _streetController.text,
      number: _numberController.text,
      complement: _complementController.text,
      district: _districtController.text,
      postalCode: _cepController.text,
      city: _cityController.text,
      state: _stateController.text,
    );

    profileBloc.add(UpdateStudentProfile(
      dataTransferObject: updateDto,
      studentId: widget.myProfileEntity?.studentId,
    ));
  }
}
