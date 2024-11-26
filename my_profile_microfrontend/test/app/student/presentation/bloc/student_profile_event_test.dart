// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';

import '../../../../util/mocks/dto_mocks.dart';

void main() {
  group('[LoadStudentProfile]', () {
    test('supports value comparisons', () {
      expect(LoadStudentProfile(), LoadStudentProfile());
    });
  });

  group('[UpdateStudentProfile]', () {
    test('supports value comparisons', () {
      expect(
        UpdateStudentProfile(
          dataTransferObject: updateAccessDataDtoMock,
        ),
        UpdateStudentProfile(
          dataTransferObject: updateAccessDataDtoMock,
        ),
      );
    });
  });
}
