import 'package:flutter/material.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/presentation/bloc/feed/feed_bloc.dart';
import 'package:feed_microfrontend/app/presentation/components/list/feed_list.dart';
import 'package:feed_microfrontend/app/presentation/components/list/feed_list_shimmer.dart';
import 'package:feed_microfrontend/app/presentation/components/scaffold/feed_app_bar.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/design_system/components/indicator/page_center_indicator.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final Translation translation = Modular.get<Translation>();
  final FeedBloc feedBloc = Modular.get<FeedBloc>();

  @override
  initState() {
    super.initState();
    feedBloc.add(const LoadFeed());
  }

  List<FeedEntity> feedEntities = [];

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return GestureDetector(
      child: ScaffoldDrawerAnimated(
        child: Scaffold(
          appBar: FeedAppBar(),
          body: BlocProvider(
            create: (_) => feedBloc,
            child: BlocConsumer<FeedBloc, FeedState>(
              listener: (_, state) => handleBlocListener(state),
              builder: (context, state) {
                return SafeArea(
                  child: SizedBox(
                    width: screen.width,
                    height: screen.height,
                    child: Stack(
                      children: [
                        // Shimmer de carregamento
                        Visibility(
                          visible: state is FeedLoading,
                          child: const FeedListShimmer(),
                        ),
                        // Lista de feed
                        if ((state is FeedSuccess || feedEntities.isNotEmpty) &&
                            state is! FeedLoading)
                          Visibility(
                            visible: (state is FeedSuccess ||
                                    feedEntities.isNotEmpty) &&
                                state is! FeedLoading,
                            child: FeedList(
                              feedEntities: feedEntities,
                              onRefresh: () => feedBloc.add(const LoadFeed()),
                              onTapFeedEntity: (FeedEntity feedEntity) =>
                                  loadSingleFeedPage(feedEntity),
                            ),
                          ),
                        // Indicador de erro
                        Visibility(
                          visible:
                              state is FeedErrorState && feedEntities.isEmpty,
                          child: PageCenterIndicator(
                            indicatorIcon: const Icon(
                              Icons.error,
                              color: Colors.grey,
                              size: 50,
                            ),
                            indicatorText: Text(
                              translation.translate(
                                key: "unknownErrorText",
                                package: "feed",
                              ),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType,
            ),
          ),
        ),
      ),
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  void handleBlocListener(state) {
    switch (state) {
      case FeedErrorState():
        showErrorDialog(
          context: context,
          title: state.feedError.dialogTitle,
          contentText: state.feedError.dialogText,
        );
        break;
      case FeedLoading():
        break;
      case FeedSuccess():
        feedEntities = state.feedEntities;
        break;
    }
  }

  void loadSingleFeedPage(FeedEntity feedEntity) {
    Modular.to.pushNamed(
      Modular.get<NavigationInjector>().getPathInPackage(
        package: "tips",
        pathKey: "single-feed",
      ),
      arguments: feedEntity,
    );
  }
}
