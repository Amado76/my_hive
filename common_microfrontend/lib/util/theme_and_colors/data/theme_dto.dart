class ThemeDto {
  final String gradientPrimaryMain;
  final String gradientSecondaryMain;
  final String primary;
  final String secondary;
  final String text;
  final String background;
  final String logoUrl;

  ThemeDto({
    required this.gradientPrimaryMain,
    required this.gradientSecondaryMain,
    required this.primary,
    required this.secondary,
    required this.text,
    required this.background,
    required this.logoUrl,
  });

  factory ThemeDto.fromJson(Map<String, dynamic> json) {
    return ThemeDto(
      gradientPrimaryMain: json['gradient']['primaryMain'],
      gradientSecondaryMain: json['gradient']['secondaryMain'],
      primary: json['primary'],
      secondary: json['secondary'],
      text: json['text'],
      background: json['background'],
      logoUrl: json['logo_url'],
    );
  }

  factory ThemeDto.defaultTheme({String themeMode = 'light'}) {
    if (themeMode == 'light') {
      return ThemeDto(
        gradientPrimaryMain: '0xFFFFFFFF',
        gradientSecondaryMain: '0xFFFFFFFF',
        primary: '0xFFFFFFFF',
        secondary: '0xFFFFFFFF',
        text: 'dark',
        background: 'ligth',
        logoUrl: '',
      );
    }
    return ThemeDto(
      gradientPrimaryMain: '0xFF000000',
      gradientSecondaryMain: '0xFF000000',
      primary: '0xFF000000',
      secondary: '0xFF000000',
      text: 'ligth',
      background: 'dark',
      logoUrl: '',
    );
  }
}
