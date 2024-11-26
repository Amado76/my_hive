// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/core/util/error/home_error.dart';
import 'package:home_microfrontend/app/home/domain/entity/banner_entity.dart';
import 'package:home_microfrontend/app/home/domain/entity/user_entity.dart';
import 'package:home_microfrontend/app/home/presentation/bloc/home_bloc.dart';
import 'package:home_microfrontend/l10n/translation_home.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

void main() {
  Modular.bindModule(GeneralConfigModular());

  GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.business = GeneralBusiness.education;
  gc.language = 'en';

  final translation = Modular.get<Translation>();
  translation.reset(business: GeneralBusiness.education);

  translation.registerTranslations(TranslationHome());
  test('supports value comparisons', () {
    expect(HomeLoading(), HomeLoading());
  });

  test('supports value comparisons', () {
    expect(
        DefaultHomeSuccess(
          userEntity: UserEntity(userAvatarPath: ''),
          bannerEntity: [
            BannerEntity(
                imageUrl: '', action: '', actionUrl: '', moduleRoute: '')
          ],
          hasCommunicationNotifications: false,
        ),
        DefaultHomeSuccess(
          userEntity: UserEntity(userAvatarPath: ''),
          bannerEntity: [
            BannerEntity(
                imageUrl: '', action: '', actionUrl: '', moduleRoute: '')
          ],
          hasCommunicationNotifications: false,
        ));
  });

  test('supports value comparisons', () {
    expect(
        TermsNotAccepted(
          terms: '',
          isDefaultHome: true,
        ),
        TermsNotAccepted(
          terms: '',
          isDefaultHome: true,
        ));
  });

  test('supports value comparisons', () {
    expect(
        HomeStateError(
          homeError: HomeErrorLinkNotFound(),
        ),
        HomeStateError(
          homeError: HomeErrorLinkNotFound(),
        ));
  });

  group('HasCommunicationNotifications extension', () {
    test('should return a bool when the state is DefaultHomeSuccess', () {
      final HomeState state = DefaultHomeSuccess(
        userEntity: UserEntity(userAvatarPath: ''),
        bannerEntity: [
          BannerEntity(imageUrl: '', action: '', actionUrl: '', moduleRoute: '')
        ],
        hasCommunicationNotifications: false,
      );
      expect(state.hasCommunicationNotifications, false);
    });

    test('should return a bool when the state is TermsNotAccepted', () {
      final HomeState state = TermsNotAccepted(
        terms: '',
        isDefaultHome: true,
        userEntity: UserEntity(userAvatarPath: ''),
        bannerEntity: [
          BannerEntity(imageUrl: '', action: '', actionUrl: '', moduleRoute: '')
        ],
        hasCommunicationNotifications: false,
      );
      expect(state.hasCommunicationNotifications, false);
    });
    test(
        'should return a null when the state is TermsNotAccepted and hasCommunication is null',
        () {
      final HomeState state = TermsNotAccepted(
        terms: '',
        isDefaultHome: true,
        userEntity: UserEntity(userAvatarPath: ''),
        bannerEntity: [
          BannerEntity(imageUrl: '', action: '', actionUrl: '', moduleRoute: '')
        ],
      );
      expect(state.hasCommunicationNotifications, false);
    });
  });
}

class TranslationMock {}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
