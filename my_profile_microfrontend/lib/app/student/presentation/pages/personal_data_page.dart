import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/student/presentation/components/form/personal_data_form.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage(
      {super.key, required this.state, this.myProfileEntity});

  final StudentProfileState state;
  final MyProfileEntity? myProfileEntity;

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        Modular.get<StudentProfileBloc>().add(const LoadStudentProfile());
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: shouldShowForm(widget.state),
              child: PersonalDataForm(
                spaceBetweenFields: 20,
                profileEntity: widget.myProfileEntity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool shouldShowForm(StudentProfileState state) {
    bool hasSuccess = state is StudentProfileSuccess;
    bool hasError = state is StudentProfileErrorState;
    bool isSubmitting = state is StudentProfileSubmitLoading;
    bool hasSubmitted = state is StudentProfileSubmitSuccess;
    bool hasProfileEntity = widget.myProfileEntity != null;

    return hasProfileEntity &&
        (hasSuccess || hasError || isSubmitting || hasSubmitted);
  }

  bool shouldShowShimmer(StudentProfileState state) {
    bool isLoading = state is StudentProfileLoading;
    bool hasErrorWithoutEntity =
        state is StudentProfileErrorState && widget.myProfileEntity == null;

    return isLoading || hasErrorWithoutEntity;
  }
}
