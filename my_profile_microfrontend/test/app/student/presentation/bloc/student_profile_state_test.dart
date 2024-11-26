import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/util/my_profile_error.dart';
import 'package:my_profile_microfrontend/l10n/translation_my_profile.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

import '../../../../util/mocks/entity_mocks.dart';

void main() {
  Modular.bindModule(GeneralConfigModular());

  GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.buildBusiness = '';
  gc.business = GeneralBusiness.education;
  gc.language = 'en';

  final translation = Modular.get<Translation>();
  translation.reset(business: GeneralBusiness.education);

  translation.registerTranslations(
    TranslationMyProfile(),
  );

  group('[StudentProfileLoading]', () {
    test('supports value comparisons', () {
      expect(const StudentProfileLoading(), const StudentProfileLoading());
    });
  });
  group('[StudentProfileSuccess]', () {
    test('supports value comparisons', () {
      expect(
        StudentProfileSuccess(myProfileEntityMock),
        StudentProfileSuccess(myProfileEntityMock),
      );
    });
  });
  group('[StudentProfileErrorState]', () {
    test('supports value comparisons', () {
      expect(
        StudentProfileErrorState(error: MyProfileUnknownError()),
        StudentProfileErrorState(error: MyProfileUnknownError()),
      );
    });
  });

  group('[StudentProfileSubmitLoading]', () {
    test('supports value comparisons', () {
      expect(
        const StudentProfileSubmitLoading(),
        const StudentProfileSubmitLoading(),
      );
    });
  });

  group('[StudentProfileSubmitSuccess]', () {
    test('supports value comparisons', () {
      expect(
        const StudentProfileSubmitSuccess(),
        const StudentProfileSubmitSuccess(),
      );
    });
  });

  group('[StudentProfileState]', () {
    test('test getters for success', () {
      final studentSuccess = StudentProfileSuccess(myProfileEntityMock);

      // Cast para StudentProfileState para acessar as extensões
      final state = studentSuccess as StudentProfileState;

      expect(state.profile, isA<MyProfileEntity>());
    });

    test('test getters for others', () {
      const profileLoadingState = StudentProfileLoading();

      const state = profileLoadingState as StudentProfileState;

      expect(state.profile, isNull);
    });
  });
}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
