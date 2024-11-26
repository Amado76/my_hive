part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

@immutable
class GetStudentHomeData extends HomeEvent {
  const GetStudentHomeData();

  @override
  List<Object?> get props => [];
}

@immutable
class AcceptUserTerms extends HomeEvent {
  const AcceptUserTerms();

  @override
  List<Object?> get props => [];
}
