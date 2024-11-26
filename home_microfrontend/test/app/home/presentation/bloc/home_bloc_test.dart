import 'package:bloc_test/bloc_test.dart';
import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/core/util/error/home_error.dart';
import 'package:home_microfrontend/app/home/domain/entity/banner_entity.dart';
import 'package:home_microfrontend/app/home/domain/entity/user_entity.dart';
import 'package:home_microfrontend/app/home/domain/use_case/get_home_data_use_case.dart';
import 'package:home_microfrontend/app/home/domain/use_case/has_communication_notifications_use_case.dart';
import 'package:home_microfrontend/app/home/presentation/bloc/home_bloc.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/accept_terms_use_case.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/get_terms_use_case.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/user_accepted_latest_terms_use_case.dart';
import 'package:home_microfrontend/l10n/translation_home.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:mocktail/mocktail.dart';

class GetHomeDataUseCaseMock extends Mock implements GetHomeDataUseCase {}

class UserAcceptedLastTermsUseCaseMock extends Mock
    implements UserAcceptedLastTermsUseCase {}

class HasCommunicationNotificationsUseCaseMock extends Mock
    implements HasCommunicationNotificationsUseCase {}

class GetTermsUseCaseMock extends Mock implements GetTermsUseCase {}

class AcceptTermsUseCaseMock extends Mock implements AcceptTermsUseCase {}

class GetCurrentProfileUseCaseMock extends Mock
    implements GetCurrentProfileUseCase {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Modular.bindModule(GeneralConfigModular());

  final GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.business = GeneralBusiness.education;
  gc.language = WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  Modular.get<Translation>().registerTranslations(
    TranslationHome(),
  );

  late HomeBloc homeBloc;
  late GetHomeDataUseCase getHomeDataUseCaseMock;
  late UserAcceptedLastTermsUseCase userAcceptedLastTermsUseCaseMock;
  late HasCommunicationNotificationsUseCase
      hasCommunicationNotificationsUseCaseMock;
  late GetTermsUseCase getTermsUseCaseMock;
  late AcceptTermsUseCase acceptTermsUseCaseMock;
  late GetCurrentProfileUseCase getCurrentProfileUseCaseMock;

  setUp(() {
    getHomeDataUseCaseMock = GetHomeDataUseCaseMock();

    userAcceptedLastTermsUseCaseMock = UserAcceptedLastTermsUseCaseMock();
    hasCommunicationNotificationsUseCaseMock =
        HasCommunicationNotificationsUseCaseMock();
    getTermsUseCaseMock = GetTermsUseCaseMock();
    acceptTermsUseCaseMock = AcceptTermsUseCaseMock();
    getCurrentProfileUseCaseMock = GetCurrentProfileUseCaseMock();

    homeBloc = HomeBloc(
      acceptTermsUseCase: acceptTermsUseCaseMock,
      getHomeDataUseCase: getHomeDataUseCaseMock,
      userAcceptedLastTermsUseCase: userAcceptedLastTermsUseCaseMock,
      getTermsUseCase: getTermsUseCaseMock,
      hasCommunicationNotificationsUseCase:
          hasCommunicationNotificationsUseCaseMock,
      getCurrentProfileUseCase: getCurrentProfileUseCaseMock,
    );
  });
  test('test initial state', () {
    expect(homeBloc.state, const HomeLoading());
  });

  group('GetStudentHomeData', () {
    blocTest<HomeBloc, HomeState>(
      'should emit [TermsNotAccepted] when the user is a default user, he do not accepted the terms and the request was sucessfull',
      setUp: () {
        when(() => getHomeDataUseCaseMock.call()).thenAnswer((_) async =>
            (bannerEntityList: bannerEntityMock, userEntity: userEntityMock));
        when(() => hasCommunicationNotificationsUseCaseMock.call())
            .thenAnswer((_) async => true);
        when(() => userAcceptedLastTermsUseCaseMock.call())
            .thenAnswer((_) async => false);
        when(() => getTermsUseCaseMock.call()).thenAnswer((_) async => 'terms');
        when(() => getCurrentProfileUseCaseMock.call())
            .thenAnswer((_) => groupEntity);
      },
      build: () => homeBloc,
      act: (homeBloc) => homeBloc.add(const GetStudentHomeData()),
      expect: () => [
        const HomeLoading(),
        const TermsNotAccepted(
          terms: 'terms',
          isDefaultHome: true,
          userEntity: userEntityMock,
          bannerEntity: bannerEntityMock,
          hasCommunicationNotifications: true,
        ),
      ],
    );
    blocTest<HomeBloc, HomeState>(
      'should emit [DefaultHomeSuccess] when the user is a default user, he accepted the terms and the request was sucessfull',
      setUp: () {
        when(() => getHomeDataUseCaseMock.call()).thenAnswer((_) async =>
            (bannerEntityList: bannerEntityMock, userEntity: userEntityMock));
        when(() => hasCommunicationNotificationsUseCaseMock.call())
            .thenAnswer((_) async => true);
        when(() => userAcceptedLastTermsUseCaseMock.call())
            .thenAnswer((_) async => true);
        when(() => getCurrentProfileUseCaseMock.call())
            .thenAnswer((_) => groupEntity);
      },
      build: () => homeBloc,
      act: (homeBloc) => homeBloc.add(const GetStudentHomeData()),
      expect: () => [
        const HomeLoading(),
        const DefaultHomeSuccess(
          userEntity: userEntityMock,
          bannerEntity: bannerEntityMock,
          hasCommunicationNotifications: true,
        ),
      ],
    );
    blocTest<HomeBloc, HomeState>(
      'should emit [HomeError] when the request was not sucessfull',
      setUp: () {
        when(() => userAcceptedLastTermsUseCaseMock.call())
            .thenThrow(GTecException(message: ''));
      },
      build: () => homeBloc,
      act: (homeBloc) => homeBloc.add(const GetStudentHomeData()),
      expect: () => [
        const HomeLoading(),
        HomeStateError(homeError: HomeErrorUnknown()),
      ],
    );
  });

  group('AcceptUserTerms', () {
    blocTest<HomeBloc, HomeState>(
      'should emit [DefaultHomeSuccess] when the user is a default user and the request was sucessfull',
      setUp: () {
        when(() => acceptTermsUseCaseMock.call()).thenAnswer((_) async => ());
      },
      build: () => homeBloc,
      seed: () => const TermsNotAccepted(
        isDefaultHome: true,
        terms: 'terms',
        userEntity: userEntityMock,
        bannerEntity: bannerEntityMock,
        hasCommunicationNotifications: true,
      ),
      act: (homeBloc) => homeBloc.add(const AcceptUserTerms()),
      expect: () => [
        const DefaultHomeSuccess(
          userEntity: userEntityMock,
          bannerEntity: bannerEntityMock,
          hasCommunicationNotifications: true,
        ),
      ],
    );
    blocTest<HomeBloc, HomeState>(
      'should emit [HomeError] when the request was not sucessfull',
      setUp: () {
        when(() => acceptTermsUseCaseMock.call())
            .thenThrow(GTecException(message: ''));
      },
      build: () => homeBloc,
      seed: () => const TermsNotAccepted(
        isDefaultHome: false,
        terms: 'terms',
        hasCommunicationNotifications: true,
      ),
      act: (homeBloc) => homeBloc.add(const AcceptUserTerms()),
      expect: () => [
        HomeStateError(homeError: HomeErrorUnknown()),
      ],
    );
  });
}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

const userEntityMock = UserEntity(userAvatarPath: '');

const List<BannerEntity> bannerEntityMock = [
  BannerEntity(
    imageUrl: '',
    action: '',
    actionUrl: '',
    moduleRoute: '',
  ),
];

// ignore: prefer_const_constructors
const GroupEntity groupEntity = GroupEntity(
  dependent: '',
  dependentId: 1,
  name: 'name',
  nameProfile: 'nameProfile',
  communityId: 1,
  logoUrl: 'logoUrl',
  roomId: 1,
  room: 'room',
);
