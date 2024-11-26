import 'package:flutter/material.dart';
import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';
import 'package:settings_microfrontend/app/presentation/bloc/settings_bloc.dart';
import 'package:settings_microfrontend/app/util/notification_settings_helper.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Translation _translation = Modular.get<Translation>();
  final SettingsBloc _settingsBloc = Modular.get<SettingsBloc>();
  final TranslationBloc _translationBloc = Modular.get<TranslationBloc>();

  @override
  void initState() {
    _settingsBloc.add(GetSettingsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final gradientStyle =
        Theme.of(context).extension<GradienteColorsExtension>();
    final String systemLanguage =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    return ScaffoldDrawerAnimated(
      child: Scaffold(
        backgroundColor: theme.brightness == Brightness.dark
            ? theme.scaffoldBackgroundColor
            : Colors.grey[50],
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  gradientStyle?.secondaryColor ?? Colors.grey[350]!,
                  gradientStyle?.primaryColor ?? Colors.grey[100]!,
                ],
              ),
            ),
          ),
          leading: const IconDrawerButtonToggle(),
          // backgroundColor: Colors.amberAccent,
          title: Text(
            _translation.translate(
              key: 'titleAppBar',
              package: 'settings',
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  BlocConsumer<SettingsBloc, SettingsState>(
                    bloc: _settingsBloc,
                    listener: (context, state) {
                      if (state is SettingsErrorState) {
                        showErrorDialog(
                          context: context,
                          title: _translation.translate(
                            key: 'errorStateTitle',
                            package: 'settings',
                          ),
                          contentText: state.message,
                        );
                      } else if (state is SettingsSuccessState) {
                        _translationBloc.changeLanguage(
                          language: state.settings.language.name == 'system'
                              ? systemLanguage
                              : state.settings.language.name,
                        );
                      }
                    },
                    builder: (context, state) {
                      switch (state) {
                        case SettingsLoadingState():
                          return _getSkeleton();
                        case SettingsErrorState():
                          return _getSkeleton();
                        case SettingsSuccessState():
                          final SettingsEntity settings = state.settings;
                          return _getListSettings(settings);

                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSkeleton() {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.separated(
          itemBuilder: (_, __) => ListTile(
            title: Container(
              width: double.infinity,
              height: 16.0,
              color: Colors.white,
            ),
            subtitle: Container(
              width: double.infinity,
              height: 14.0,
              color: Colors.white,
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: 2,
        ),
      ),
    );
  }

  Widget _getListSettings(SettingsEntity settings) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, __) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _translation.translate(
                            key: 'languageMenu',
                            package: 'settings',
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          settings.language.nameToUI,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        createFlag(
                          flagPath: 'assets/images/flag_system.png',
                          onTap: () {
                            _settingsBloc.add(
                              ChangeSettingsEvent(
                                settings: SettingsEntity(
                                  language: Language.system,
                                ),
                              ),
                            );
                          },
                          isSelected: settings.language == Language.system,
                        ),
                        createFlag(
                          flagPath: 'assets/images/flag_brazil.png',
                          onTap: () {
                            _settingsBloc.add(
                              ChangeSettingsEvent(
                                settings: SettingsEntity(
                                  language: Language.pt,
                                ),
                              ),
                            );
                          },
                          isSelected: settings.language == Language.pt,
                        ),
                        createFlag(
                          flagPath: 'assets/images/flag_usa.png',
                          onTap: () {
                            _settingsBloc.add(
                              ChangeSettingsEvent(
                                settings: SettingsEntity(
                                  language: Language.en,
                                ),
                              ),
                            );
                          },
                          isSelected: settings.language == Language.en,
                        ),
                        createFlag(
                          flagPath: 'assets/images/flag_spain.png',
                          onTap: () {
                            _settingsBloc.add(
                              ChangeSettingsEvent(
                                settings: SettingsEntity(
                                  language: Language.es,
                                ),
                              ),
                            );
                          },
                          isSelected: settings.language == Language.es,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black38,
              ),
              ListTile(
                title: Text(
                    _translation.translate(
                      key: 'notificationTitle',
                      package: 'settings',
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(
                  _translation.translate(
                    key: 'notificationSubtitle',
                    package: 'settings',
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  await NotificationSettingsHelper.openNotificationSettings(
                    context,
                  );
                },
              ),
              ListTile(
                title: Text(
                    _translation.translate(
                      key: 'requestAccountDeletionTitle',
                      package: 'settings',
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(
                  _translation.translate(
                    key: 'requestAccountDeletionSubtitle',
                    package: 'settings',
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  showDefaultDialog(
                    context: context,
                    title: _translation.translate(
                      key: 'successRequestAccountDeletionTitle',
                      package: 'settings',
                    ),
                    contentText: _translation.translate(
                      key: 'successRequestAccountDeletionSubtitle',
                      package: 'settings',
                    ),
                  );
                },
              ),
            ],
          );
        },
        itemCount: 1,
      ),
    );
  }

  Widget createFlag({
    required String flagPath,
    required void Function() onTap,
    bool isSelected = false,
  }) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.yellowAccent : Colors.transparent,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          child: Image.asset(
            width: 40,
            height: 40,
            flagPath,
            package: 'settings_microfrontend',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
