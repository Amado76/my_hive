import 'package:flutter/material.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/student/presentation/components/student_profile_app_bar.dart';
import 'package:my_profile_microfrontend/app/student/presentation/pages/access_data_page.dart';
import 'package:my_profile_microfrontend/app/student/presentation/pages/address_page.dart';
import 'package:my_profile_microfrontend/app/student/presentation/pages/documents_page.dart';
import 'package:my_profile_microfrontend/app/student/presentation/pages/personal_data_page.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key, required this.isoCode});
  final String? isoCode;
  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final StudentProfileBloc profileBloc = Modular.get<StudentProfileBloc>();
  MyProfileEntity? myProfileEntity;

  @override
  initState() {
    super.initState();
    profileBloc.add(const LoadStudentProfile());
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return GestureDetector(
      child: DefaultTabController(
        length: 4,
        child: ScaffoldDrawerAnimated(
          child: Scaffold(
            appBar: StudentProfileAppBar(),
            body: BlocProvider(
              create: (_) => profileBloc,
              child: BlocConsumer<StudentProfileBloc, StudentProfileState>(
                listener: (_, state) => handleBlocListener(state),
                builder: (context, state) {
                  return SafeArea(
                    child: SizedBox(
                      // decoration: const BoxDecoration(color: Color(0xFFF4F4F4)),
                      width: screen.width,
                      height: screen.height,
                      child: TabBarView(
                        children: [
                          PersonalDataPage(
                              state: state, myProfileEntity: myProfileEntity),
                          AccessDataPage(
                              state: state,
                              entity: myProfileEntity,
                              isoCode: widget.isoCode),
                          AddressPage(
                              state: state, myProfileEntity: myProfileEntity),
                          DocumentsPage(
                              state: state, myProfileEntity: myProfileEntity),
                        ],
                      ),
                    ),
                  );
                },
                buildWhen: (previous, current) =>
                    previous.runtimeType != current.runtimeType,
              ),
            ),
          ),
        ),
      ),
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  void handleBlocListener(state) {
    final Translation translation = Modular.get<Translation>();

    switch (state) {
      case StudentProfileErrorState():
        showErrorDialog(
          context: context,
          title: state.error.dialogTitle,
          contentText: state.error.dialogText,
        );
        break;
      case StudentProfileSuccess():
        myProfileEntity = state.profile;
        break;
      case StudentProfileSubmitSuccess():
        showSuccessDialog(
          context: context,
          title:
              translation.translate(key: 'successTitle', package: 'my_profile'),
          contentText: translation.translate(
              key: 'updatedProfile', package: 'my_profile'),
        );
        profileBloc.add(const LoadStudentProfile());
        break;
    }
  }
}
