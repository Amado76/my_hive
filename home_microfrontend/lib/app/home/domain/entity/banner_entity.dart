import 'package:common_microfrontend/common_microfrontend.dart';

class BannerEntity extends Equatable {
  final String imageUrl;
  final String action;
  final String? actionUrl;
  final String? moduleRoute;

  const BannerEntity({
    required this.imageUrl,
    required this.action,
    required this.actionUrl,
    required this.moduleRoute,
  });

  factory BannerEntity.fromMap(Map<String, dynamic> map) {
    return BannerEntity(
      imageUrl: map['imageUrl'],
      action: map['action'],
      actionUrl: map['actionUrl'],
      moduleRoute: map['moduleRoute'],
    );
  }

  @override
  List<Object?> get props => [imageUrl, action, actionUrl, moduleRoute];
}
