// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/my_profile_repository_interface.dart';
import 'package:my_profile_microfrontend/app/core/domain/usecases/update_profile_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MyProfileRepositoryMock extends Mock
    implements MyProfileRepositoryInterface {}

void main() {
  late MyProfileRepositoryInterface profileRepository;
  late UpdateProfileUseCase updateProfileUseCase;

  setUp(() {
    profileRepository = MyProfileRepositoryMock();
    updateProfileUseCase = UpdateProfileUseCase(profileRepository);
  });

  group('[UpdateProfileUseCase]', () {});
}
