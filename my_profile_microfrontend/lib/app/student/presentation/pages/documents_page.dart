import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/student/presentation/components/form/documents_form.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key, required this.state, this.myProfileEntity});

  final StudentProfileState state;
  final MyProfileEntity? myProfileEntity;

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
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
              child: DocumentsForm(
                spaceBetweenFields: 20,
                documentsEntity: widget.myProfileEntity?.documents,
                myProfileEntity: widget.myProfileEntity,
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
