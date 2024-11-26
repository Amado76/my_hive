import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/widgets.dart';
import 'package:home_microfrontend/app/core/util/error/home_error.dart';
import 'package:home_microfrontend/app/home/domain/entity/banner_entity.dart';
import 'package:home_microfrontend/app/home/domain/entity/user_entity.dart';
import 'package:home_microfrontend/app/home/domain/use_case/get_home_data_use_case.dart';
import 'package:home_microfrontend/app/home/domain/use_case/has_communication_notifications_use_case.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/accept_terms_use_case.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/get_terms_use_case.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/user_accepted_latest_terms_use_case.dart';

import 'package:common_microfrontend/common_microfrontend.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetHomeDataUseCase getHomeDataUseCase,
    required UserAcceptedLastTermsUseCase userAcceptedLastTermsUseCase,
    required GetTermsUseCase getTermsUseCase,
    required HasCommunicationNotificationsUseCase
        hasCommunicationNotificationsUseCase,
    required AcceptTermsUseCase acceptTermsUseCase,
    required GetCurrentProfileUseCase getCurrentProfileUseCase,
  })  : _getHomeDataUseCase = getHomeDataUseCase,
        _userAcceptedLastTermsUseCase = userAcceptedLastTermsUseCase,
        _getTermsUseCase = getTermsUseCase,
        _hasCommunicationNotificationsUseCase =
            hasCommunicationNotificationsUseCase,
        _acceptTermsUseCase = acceptTermsUseCase,
        _getCurrentProfileUseCase = getCurrentProfileUseCase,
        super(const HomeLoading()) {
    on<GetStudentHomeData>(_onGetStudentHomeData);
    on<AcceptUserTerms>(_onAcceptUserTerms);
  }
  final GetHomeDataUseCase _getHomeDataUseCase;
  final UserAcceptedLastTermsUseCase _userAcceptedLastTermsUseCase;
  final AcceptTermsUseCase _acceptTermsUseCase;
  final GetTermsUseCase _getTermsUseCase;
  final HasCommunicationNotificationsUseCase
      _hasCommunicationNotificationsUseCase;
  final GetCurrentProfileUseCase _getCurrentProfileUseCase;

  void _onAcceptUserTerms(
      AcceptUserTerms event, Emitter<HomeState> emit) async {
    try {
      final state = this.state as TermsNotAccepted;
      final isDefaultHome = state.isDefaultHome;
      await _acceptTermsUseCase.call();

      if (isDefaultHome) {
        final UserEntity userEntity = state.userEntity!;
        final List<BannerEntity> bannerEntity = state.bannerEntity!;
        final bool hasCommunicationNotifications =
            state.hasCommunicationNotifications!;
        emit(DefaultHomeSuccess(
          userEntity: userEntity,
          bannerEntity: bannerEntity,
          hasCommunicationNotifications: hasCommunicationNotifications,
        ));

        return;
      }
    } on Exception catch (e) {
      emit(HomeStateError(homeError: HomeError.from(e)));
    }
  }

  void _onGetStudentHomeData(
      GetStudentHomeData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    try {
      bool userAcceptTerms = await _userAcceptedLastTermsUseCase.call();
      bool hasCommunicationNotifications =
          await _hasCommunicationNotificationsUseCase.call();
      final homeDataResult = await _getHomeDataUseCase.call();
      final UserEntity userEntity = homeDataResult.userEntity;
      final List<BannerEntity> bannerEntity = homeDataResult.bannerEntityList;
      final String? logoPath = _getCurrentProfileUseCase.call().logoUrl;

      if (!userAcceptTerms) {
        final String terms = await _getTermsUseCase.call();
        emit(TermsNotAccepted(
          hasCommunicationNotifications: hasCommunicationNotifications,
          userEntity: userEntity,
          bannerEntity: bannerEntity,
          terms: terms,
          isDefaultHome: true,
          logoPath: logoPath,
        ));
        return;
      }

      emit(DefaultHomeSuccess(
        hasCommunicationNotifications: hasCommunicationNotifications,
        userEntity: userEntity,
        bannerEntity: bannerEntity,
        logoPath: logoPath,
      ));
    } on Exception catch (e) {
      emit(HomeStateError(homeError: HomeError.from(e)));
    }
  }
}
