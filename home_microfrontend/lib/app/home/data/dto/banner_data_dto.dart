class BannerDataDto {
  final String imageUrl;
  final String action;
  final String? actionUrl;
  final String? moduleRoute;

  BannerDataDto({
    required this.imageUrl,
    required this.action,
    required this.actionUrl,
    required this.moduleRoute,
  });

  factory BannerDataDto.fromJson(Map<String, dynamic> json) {
    return BannerDataDto(
      imageUrl: json['url_image'],
      action: json['action'],
      actionUrl: json['url'],
      moduleRoute: json['area'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'action': action,
      'actionUrl': actionUrl,
      'moduleRoute': moduleRoute,
    };
  }
}
