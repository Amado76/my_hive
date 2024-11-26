part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();
}

@immutable
class HomeLoading extends HomeState {
  const HomeLoading();
  @override
  List<Object?> get props => [];
}

@immutable
class DefaultHomeSuccess extends HomeState {
  const DefaultHomeSuccess({
    required this.userEntity,
    required this.bannerEntity,
    required this.hasCommunicationNotifications,
    this.logoPath,
  });

  final UserEntity userEntity;
  final List<BannerEntity> bannerEntity;
  final bool hasCommunicationNotifications;
  final String? logoPath;

  @override
  List<Object?> get props => [
        userEntity,
        bannerEntity,
        hasCommunicationNotifications,
      ];
}

@immutable
class TermsNotAccepted extends HomeState {
  const TermsNotAccepted(
      {required this.terms,
      required this.isDefaultHome,
      this.userEntity,
      this.bannerEntity,
      this.hasCommunicationNotifications,
      this.logoPath});

  final UserEntity? userEntity;
  final List<BannerEntity>? bannerEntity;
  final String terms;
  final bool? hasCommunicationNotifications;
  final bool isDefaultHome;
  final String? logoPath;

  @override
  List<Object?> get props => [
        isDefaultHome,
        userEntity,
        bannerEntity,
        terms,
        hasCommunicationNotifications,
      ];
}

@immutable
class HomeStateError extends HomeState {
  const HomeStateError({
    required this.homeError,
  });
  final HomeError homeError;

  @override
  List<Object?> get props => [homeError];
}

extension HasCommunicationNotifications on HomeState {
  bool get hasCommunicationNotifications {
    final state = this;
    if (state is DefaultHomeSuccess) {
      return (this as DefaultHomeSuccess).hasCommunicationNotifications;
    }
    if (state is TermsNotAccepted &&
        (this as TermsNotAccepted).hasCommunicationNotifications != null) {
      return (this as TermsNotAccepted).hasCommunicationNotifications!;
    }
    return false;
  }
}
