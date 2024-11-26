import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/student/presentation/components/form/access_data_form.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class AccessDataPage extends StatefulWidget {
  const AccessDataPage(
      {super.key, required this.state, this.entity, required this.isoCode});

  final StudentProfileState state;
  final MyProfileEntity? entity;
  final String? isoCode;

  @override
  State<AccessDataPage> createState() => _AccessDataPageState();
}

class _AccessDataPageState extends State<AccessDataPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        Modular.get<StudentProfileBloc>().add(const LoadStudentProfile());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Visibility(
              visible: shouldShowForm(widget.state),
              child: AccessDataForm(
                isoCode: widget.isoCode,
                spaceBetweenFields: 20,
                entity: widget.entity,
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
    bool hasProfileEntity = widget.entity != null;

    return hasProfileEntity &&
        (hasSuccess || hasError || isSubmitting || hasSubmitted);
  }

  bool shouldShowShimmer(StudentProfileState state) {
    bool isLoading = state is StudentProfileLoading;
    bool hasErrorWithoutEntity =
        state is StudentProfileErrorState && widget.entity == null;

    return isLoading || hasErrorWithoutEntity;
  }
}
