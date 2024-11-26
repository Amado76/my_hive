import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';
import 'package:settings_microfrontend/app/domain/interfaces/settings_language_repository_interface.dart';
import 'package:settings_microfrontend/app/presentation/bloc/settings_bloc.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsRepository extends Mock
    implements SettingsLanguageRepositoryInterface {}

void main() {
  late SettingsBloc settingsBloc;
  late MockSettingsRepository mockSettingsRepository;
  late SettingsEntity testSettings;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    settingsBloc = SettingsBloc(repository: mockSettingsRepository);
    testSettings = SettingsEntity(language: Language.en);
  });

  tearDown(() {
    settingsBloc.close();
  });

  group('SettingsBloc', () {
    blocTest<SettingsBloc, SettingsState>(
      'emits [SettingsLoadingState, SettingsSuccessState] when GetSettingsEvent is added and retrieve is successful',
      build: () {
        when(
          () => mockSettingsRepository.retrieve(),
        ).thenAnswer(
          (_) async => testSettings,
        );
        return settingsBloc;
      },
      act: (bloc) => bloc.add(
        GetSettingsEvent(),
      ),
      wait: const Duration(
        seconds: 2,
      ),
      expect: () => [
        SettingsLoadingState(),
        SettingsSuccessState(
          settings: testSettings,
        ),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'emits [SettingsLoadingState, SettingsErrorState] when GetSettingsEvent is added and retrieve fails',
      build: () {
        when(
          () => mockSettingsRepository.retrieve(),
        ).thenThrow(
          GTecException(
            message: 'Failed to retrieve settings',
          ),
        );
        return settingsBloc;
      },
      act: (bloc) => bloc.add(
        GetSettingsEvent(),
      ),
      wait: const Duration(
        seconds: 1,
      ), // Adiciona um tempo de espera
      expect: () => [
        SettingsLoadingState(),
        SettingsErrorState(
          message: 'Failed to retrieve settings',
        ),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'emits [SettingsLoadingState, SettingsSuccessState] when ChangeSettingsEvent is added and save is successful',
      build: () {
        when(
          () => mockSettingsRepository.save(
            language: Language.en,
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );
        when(
          () => mockSettingsRepository.retrieve(),
        ).thenAnswer(
          (_) async => testSettings,
        );
        return settingsBloc;
      },
      act: (bloc) => bloc.add(
        ChangeSettingsEvent(
          settings: testSettings,
        ),
      ),
      wait: const Duration(
        seconds: 1,
      ), // Adiciona um tempo de espera
      expect: () => [
        SettingsLoadingState(),
        SettingsSuccessState(
          settings: testSettings,
        ),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'emits [SettingsLoadingState, SettingsErrorState] when ChangeSettingsEvent is added and save fails',
      build: () {
        when(() => mockSettingsRepository.save(language: Language.en))
            .thenThrow(
          GTecException(
            message: 'Failed to save settings',
          ),
        );
        return settingsBloc;
      },
      act: (bloc) => bloc.add(
        ChangeSettingsEvent(
          settings: testSettings,
        ),
      ),
      wait: const Duration(
        seconds: 1,
      ), // Adiciona um tempo de espera
      expect: () => [
        SettingsLoadingState(),
        SettingsErrorState(
          message: 'Failed to save settings',
        ),
      ],
    );
  });
}
