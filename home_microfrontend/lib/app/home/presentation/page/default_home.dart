import 'package:flutter/material.dart';
import 'package:home_microfrontend/app/home/domain/entity/banner_entity.dart';
import 'package:home_microfrontend/app/home/presentation/components/avatar/home_avatar_widget.dart';
import 'package:home_microfrontend/app/home/presentation/components/caroulsel/home_caroulsel_widget.dart';
import 'package:home_microfrontend/app/home/presentation/components/custom_buttons/home_buttons_widget.dart';
import 'package:home_microfrontend/app/home/presentation/components/user_name_home_widget.dart';

class DefaultHome extends StatefulWidget {
  const DefaultHome({
    super.key,
    required this.currentIndex,
    required this.onCarouselPageChanged,
    required this.userAvatarPath,

    // required this.listBannerEntity,
  });
  final int currentIndex;
  final Function(int index) onCarouselPageChanged;
  final String? userAvatarPath;

  @override
  State<DefaultHome> createState() => _DefaultHomeState();
}

class _DefaultHomeState extends State<DefaultHome> {
  final List<BannerEntity>? listBannerEntity = listBannerEntityFake;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        HomeAvatarWidget(
          avatarPath: widget.userAvatarPath,
        ),
        const SizedBox(height: 30),
        HomeCaroulselWidget(
          listBannerEntity: listBannerEntityFake,
          currentIndex: widget.currentIndex,
          onPageChanged: widget.onCarouselPageChanged,
        ),
        const SizedBox(height: 20),
        const HomeButtonsWidget(),
      ],
    );
  }
}

class DefaultLoadingHome extends StatefulWidget {
  const DefaultLoadingHome(
      {super.key,
      required this.currentIndex,
      required this.onCarouselPageChanged});
  final int currentIndex;
  final Function(int index) onCarouselPageChanged;

  @override
  State<DefaultLoadingHome> createState() => _DefaultLoadingHomeState();
}

class _DefaultLoadingHomeState extends State<DefaultLoadingHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeAvatarLoadingWidget(),
        const SizedBox(height: 30),
        const UserNameHomeLoadingWidget(),
        const SizedBox(height: 20),
        HomeCaroulselLoadingWidget(
          currentIndex: widget.currentIndex,
          onPageChanged: widget.onCarouselPageChanged,
        ),
        const SizedBox(height: 20),
        const HomeButtonsLoadingWidget()
      ],
    );
  }
}

final List<BannerEntity> listBannerEntityFake = [
  const BannerEntity(
      imageUrl:
          "https://www.hypatiaeducation.com/assets/base/img/uploads/63f6010ac51e3Homeschooling.jpg",
      action: 'link',
      actionUrl: null,
      moduleRoute: null),
  const BannerEntity(
      imageUrl:
          "https://annarborfamily-com-images.s3.amazonaws.com/wp-content/uploads/2017/08/home-school-696x348.png",
      action: 'link',
      actionUrl: null,
      moduleRoute: null),
  const BannerEntity(
      imageUrl:
          "https://www.communityfirstoxon.org/wp-content/uploads/2021/03/community.jpg",
      action: 'link',
      actionUrl: null,
      moduleRoute: null),
];
