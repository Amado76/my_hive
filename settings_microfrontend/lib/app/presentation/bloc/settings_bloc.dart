import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';
import 'package:settings_microfrontend/app/domain/interfaces/settings_language_repository_interface.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsLanguageRepositoryInterface repository;

  SettingsBloc({required this.repository}) : super(SettingsLoadingState()) {
    on<GetSettingsEvent>((event, emit) async {
      try {
        emit(SettingsLoadingState());
        await Future.delayed(const Duration(seconds: 1));
        final SettingsEntity settings = await repository.retrieve();
        emit(SettingsSuccessState(settings: settings));
      } on GTecException catch (e) {
        emit(SettingsErrorState(message: e.message));
      }
    });

    on<ChangeSettingsEvent>((event, emit) async {
      try {
        emit(SettingsLoadingState());
        await Future.delayed(const Duration(seconds: 1));
        await repository.save(language: event.settings.language);
        final SettingsEntity settings = await repository.retrieve();
        emit(SettingsSuccessState(settings: settings));
      } on GTecException catch (e) {
        emit(SettingsErrorState(message: e.message));
      }
    });
  }
}
