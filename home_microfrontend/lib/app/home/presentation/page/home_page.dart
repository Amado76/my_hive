import 'package:common_microfrontend/util/theme_and_colors/domain/util/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:home_microfrontend/app/core/util/format_html.dart';
import 'package:home_microfrontend/app/home/domain/entity/banner_entity.dart';
import 'package:home_microfrontend/app/home/presentation/bloc/home_bloc.dart';
import 'package:home_microfrontend/app/home/presentation/page/default_home.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  bool isLoading = true;
  bool isDefaultHome = true;
  late GeneralConfig generalConfig;
  String? userAvatarPath;
  List<BannerEntity>? listBannerEntity;
  String? logoPath;

  void onCarouselPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    final HomeBloc homeBloc = Modular.get<HomeBloc>();
    homeBloc.add(const GetStudentHomeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = Modular.get<HomeBloc>();
    final gradientStyle =
        Theme.of(context).extension<GradienteColorsExtension>();

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        switch (state) {
          case HomeStateError():
            isLoading = false;
            showErrorDialog(
                context: context,
                title: state.homeError.dialogTitle,
                contentText: state.homeError.dialogText);
            break;
          case TermsNotAccepted():
            termsDialog(context: context, terms: state.terms);
            break;
          case HomeLoading():
            isLoading = true;
            break;
          case DefaultHomeSuccess():
            userAvatarPath = state.userEntity.userAvatarPath;
            listBannerEntity = state.bannerEntity;
            logoPath = state.logoPath;
            isLoading = false;
            break;
        }
      },
      builder: (context, state) {
        return ScaffoldDrawerAnimated(
          child: Scaffold(
              appBar: AppBar(
                  title: Text(" My Hive Community",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(HexColor.intFromHex('#b27d00')),
                          fontWeight: FontWeight.bold)),
                  backgroundColor: isLoading
                      ? Colors.grey[300]
                      : gradientStyle?.secondaryColor ?? Colors.grey[300],
                  elevation: 0,
                  leading: isLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[350]!,
                          highlightColor: Colors.grey[100]!,
                          child: const DrawerButton())
                      : const IconDrawerButtonToggle(),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 150,
                        child: Tab(
                            child: Image.asset('assets/images/logo.png',
                                package: 'home_microfrontend',
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox())),
                      ),
                    )
                  ]),
              body: SingleChildScrollView(
                child: SafeArea(
                    child: (isLoading)
                        ? DefaultLoadingHome(
                            currentIndex: currentIndex,
                            onCarouselPageChanged: onCarouselPageChanged,
                          )
                        : DefaultHome(
                            userAvatarPath: userAvatarPath,
                            currentIndex: currentIndex,
                            onCarouselPageChanged: onCarouselPageChanged,
                          )),
              )),
        );
      },
    );
  }

  Future<dynamic> termsDialog(
      {required BuildContext context, required String terms}) {
    final HomeBloc homeBloc = Modular.get<HomeBloc>();
    return showDefaultDialog(
        customAction: Column(
          children: [
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Modular.get<Translation>()
                          .translate(package: "home", key: "decline"),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
                TextButton(
                    onPressed: () {
                      homeBloc.add(const AcceptUserTerms());

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Modular.get<Translation>()
                          .translate(package: "home", key: "accept"),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
              ],
            ),
          ],
        ),
        context: context,
        title: Modular.get<Translation>()
            .translate(key: "termsOfUse", package: "home"),
        customContentWidget: SingleChildScrollView(
          child: Text(
            formatHtml(terms),
            textAlign: TextAlign.justify,
          ),
        ));
  }
}
