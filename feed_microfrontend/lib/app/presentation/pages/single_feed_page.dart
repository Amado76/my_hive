import 'package:flutter/material.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/presentation/bloc/single_feed/single_feed_bloc.dart';
import 'package:feed_microfrontend/app/presentation/components/list/single_feed_list.dart';
import 'package:feed_microfrontend/app/presentation/components/scaffold/single_feed_app_bar.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';

class SingleFeedPage extends StatefulWidget {
  const SingleFeedPage({super.key});

  @override
  State<SingleFeedPage> createState() => _SingleFeedPageState();
}

class _SingleFeedPageState extends State<SingleFeedPage> {
  final Translation translation = Modular.get<Translation>();
  final SingleFeedBloc singleFeedBloc = Modular.get<SingleFeedBloc>();
  FeedEntity feedEntity = Modular.args.data as FeedEntity;

  @override
  initState() {
    super.initState();
    singleFeedBloc.add(GetSingleFeedDetails(feedEntity));
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();

    return GestureDetector(
      child: Scaffold(
        appBar: SingleFeedAppBar(),
        body: BlocProvider.value(
          value: singleFeedBloc,
          child: BlocConsumer<SingleFeedBloc, SingleFeedState>(
            listener: (_, state) => handleBlocListener(state),
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: themeMode!.backgroundColor,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: SingleFeedList(feedEntity: feedEntity),
                ),
              );
            },
          ),
        ),
      ),
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  void handleBlocListener(state) {
    switch (state) {
      case SingleFeedErrorState():
        break;
      case SingleFeedLoading():
        break;
      case SingleFeedSuccess():
        feedEntity = state.feedEntity;
        break;
    }
  }
}
