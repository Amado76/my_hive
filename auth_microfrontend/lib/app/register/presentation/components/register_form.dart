import 'package:flutter/material.dart';
import 'package:auth_microfrontend/app/register/presentation/bloc/register_bloc.dart';
import 'package:auth_microfrontend/app/register/util/password_matches_validation_mixin.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/validation/email_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';
import 'package:common_microfrontend/util/validation/cpf_validation_mixin.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm(
      {super.key,
      this.avatarImage,
      required this.phoneNumber,
      required this.authTextColor});
  final XFile? avatarImage;
  final String phoneNumber;
  final Color authTextColor;

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm>
    with
        ValidationMixin,
        PasswordMatchesValidationMixin,
        EmailValidationMixin,
        CpfValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _surnameController = TextEditingController();
  final _classCodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _surnameController.dispose();
    _classCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = Modular.get<RegisterBloc>();
    final Translation translation = Modular.get<Translation>();
    const double textFormPadding = 10;

    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
                textColor: widget.authTextColor,
                fillColor: widget.authTextColor.withOpacity(0.2),
                hintText: translation.translate(
                    package: 'authentication', key: 'registerName'),
                validator: (name) {
                  String? result = combine([
                    () => isNotNull(name),
                    () => isNotEmpty(name),
                  ]);
                  return result;
                },
                controller: _nameController),
            const SizedBox(height: textFormPadding),
            CustomTextFormField(
                textColor: widget.authTextColor,
                fillColor: widget.authTextColor.withOpacity(0.2),
                hintText: translation.translate(
                    package: 'authentication', key: 'registerSurname'),
                validator: (surname) {
                  String? result = combine([
                    () => isNotNull(surname),
                    () => isNotEmpty(surname),
                  ]);
                  return result;
                },
                controller: _surnameController),
            const SizedBox(height: textFormPadding),
            CustomTextFormField(
                textColor: widget.authTextColor,
                fillColor: widget.authTextColor.withOpacity(0.2),
                hintText: translation.translate(
                    package: 'authentication', key: 'registerEmail'),
                validator: (email) {
                  String? result = combine([
                    () => isNotNull(email),
                    () => isNotEmpty(email),
                    () => isValidEmail(email!),
                  ]);
                  return result;
                },
                controller: _emailController),
            const SizedBox(height: textFormPadding),
            CustomTextFormField(
                textColor: widget.authTextColor,
                fillColor: widget.authTextColor.withOpacity(0.2),
                hintText: translation.translate(
                    package: 'authentication', key: 'registerCpf'),
                validator: (cpf) {
                  String? result = combine([
                    () => isNotNull(cpf),
                    () => isNotEmpty(cpf),
                    () => isValidCpf(cpf!),
                  ]);
                  return result;
                },
                controller: _cpfController),
            const SizedBox(height: textFormPadding),
            CustomPasswordFormField(
              textColor: widget.authTextColor,
              fillColor: widget.authTextColor.withOpacity(0.2),
              iconColor: widget.authTextColor,
              hintText: translation.translate(
                  package: 'authentication', key: 'password'),
              controller: _passwordController,
              validator: (password) {
                String? result = combine([
                  () => isNotNull(password),
                  () => isNotEmpty(password),
                ]);
                return result;
              },
            ),
            const SizedBox(height: textFormPadding),
            CustomPasswordFormField(
              textColor: widget.authTextColor,
              fillColor: widget.authTextColor.withOpacity(0.2),
              iconColor: widget.authTextColor,
              hintText: translation.translate(
                  package: 'authentication', key: 'registerConfirmPassword'),
              controller: _confirmPasswordController,
              validator: (confirmPassword) {
                String? result = combine([
                  () => isNotNull(confirmPassword),
                  () => isNotEmpty(confirmPassword),
                  () => passwordMatches(
                      _passwordController.text, confirmPassword),
                ]);
                return result;
              },
            ),
            const SizedBox(height: textFormPadding),
            CustomTextFormField(
                textColor: widget.authTextColor,
                fillColor: widget.authTextColor.withOpacity(0.2),
                hintText: translation.translate(
                    package: 'authentication', key: 'registerClassCode'),
                validator: (classCode) {
                  return null;
                },
                controller: _classCodeController),
            const SizedBox(height: textFormPadding),
            CustomElevatedButton(
              text: translation.translate(
                  package: 'authentication', key: 'register'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registerBloc.add(RegisterNewUser(
                    image: widget.avatarImage,
                    email: _emailController.text,
                    password: _passwordController.text,
                    firstName: _nameController.text,
                    lastName: _surnameController.text,
                    phoneNumber: widget.phoneNumber,
                    cpf: _cpfController.text,
                    classCode: _classCodeController.text,
                  ));
                }
              },
            ),
          ],
        ));
  }
}
