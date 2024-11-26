import 'package:flutter/material.dart';
import 'package:home_microfrontend/app/core/util/url_launcher/url_launcher.dart';
import 'package:home_microfrontend/app/home/domain/entity/banner_entity.dart';
import 'package:home_microfrontend/app/home/domain/entity/module_data_entity.dart';
import 'package:home_microfrontend/app/home/domain/module_data_chain_node.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class HomeCaroulselWidget extends StatefulWidget {
  final int currentIndex;
  final List<BannerEntity>? listBannerEntity;
  final Function(int index) onPageChanged;
  const HomeCaroulselWidget({
    super.key,
    required this.currentIndex,
    required this.onPageChanged,
    required this.listBannerEntity,
  });

  @override
  State<HomeCaroulselWidget> createState() => _HomeCaroulselWidgetState();
}

class _HomeCaroulselWidgetState extends State<HomeCaroulselWidget> {
  bool _isBannerLoading = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    final ModuleDataChainNode moduleDataChainNode = ModuleDataChainNode();
    final Translation translation = Modular.get<Translation>();

    return Column(
      children: [
        widget.listBannerEntity == null
            ? Container()
            : CarouselSlider(
                options: CarouselOptions(
                    onPageChanged: ((index, reason) {
                      widget.onPageChanged(index);
                    }),
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    height: size.height * 0.21,
                    enlargeCenterPage: true),
                items: widget.listBannerEntity!.map((banner) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(1),
                                offset: const Offset(0, 0),
                                blurRadius: 8,
                                spreadRadius: -6,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (banner.action == "link") {
                              UrlLauncher()
                                  .call(urlString: banner.actionUrl ?? '');
                            }
                            if (banner.action == "page") {
                              final ModuleDataEntity? moduleData =
                                  moduleDataChainNode
                                      .moduleData(banner.moduleRoute ?? '');
                              Modular.to.pushNamed(navigator.getPath(
                                  package: moduleData!.package,
                                  pathKey: moduleData.pathKey));
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: size.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF000000)
                                              .withOpacity(1),
                                          offset: const Offset(0, 0),
                                          blurRadius: 8,
                                          spreadRadius: -6,
                                        ),
                                      ],
                                      color: Colors.red[300],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        translation.translate(
                                            package: 'home', key: 'imageError'),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                );
                              },
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                _isBannerLoading = frame == null;
                                return child;
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (!_isBannerLoading &&
                                    loadingProgress == null) {
                                  return child;
                                }
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF000000)
                                                .withOpacity(1),
                                            offset: const Offset(0, 0),
                                            blurRadius: 8,
                                            spreadRadius: -6,
                                          ),
                                        ],
                                        color: Colors.grey,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                );
                              },
                              banner.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
        const SizedBox(height: 10),
        widget.listBannerEntity == null
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children:
                        List<Widget>.from(widget.listBannerEntity!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: widget.currentIndex ==
                                    widget.listBannerEntity!.indexOf(i)
                                ? 20
                                : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF000000).withOpacity(1),
                                  offset: const Offset(0, 0),
                                  blurRadius: 8,
                                  spreadRadius: -6,
                                ),
                              ],
                              color: widget.currentIndex ==
                                      widget.listBannerEntity!.indexOf(i)
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              borderRadius: widget.currentIndex ==
                                      widget.listBannerEntity!.indexOf(i)
                                  ? BorderRadius.circular(5)
                                  : BorderRadius.circular(10),
                            ),
                          );
                        },
                      );
                    })),
                  ),
                ],
              ),
      ],
    );
  }
}

class HomeCaroulselLoadingWidget extends StatefulWidget {
  final int currentIndex;
  final Function(int index) onPageChanged;
  const HomeCaroulselLoadingWidget(
      {super.key, required this.currentIndex, required this.onPageChanged});

  @override
  State<HomeCaroulselLoadingWidget> createState() =>
      _HomeCaroulselLoadingWidgetState();
}

class _HomeCaroulselLoadingWidgetState
    extends State<HomeCaroulselLoadingWidget> {
  List<int> countBanner = [0, 1, 2];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              onPageChanged: ((index, reason) {
                widget.onPageChanged(index);
              }),
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              height: size.height * 0.21,
              enlargeCenterPage: true),
          items: countBanner.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(1),
                            offset: const Offset(0, 0),
                            blurRadius: 8,
                            spreadRadius: -6,
                          ),
                        ],
                        color: Colors.grey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: List<Widget>.from(countBanner.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: widget.currentIndex == countBanner.indexOf(i)
                            ? 20
                            : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: widget.currentIndex == countBanner.indexOf(i)
                              ? Colors.red
                              : Colors.grey,
                          borderRadius:
                              widget.currentIndex == countBanner.indexOf(i)
                                  ? BorderRadius.circular(5)
                                  : BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                );
              })),
            ),
          ],
        ),
      ],
    );
  }
}
