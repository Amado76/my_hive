import 'package:common_microfrontend/common_microfrontend.dart';

class UrlLauncher {
  Future<void> call({required String urlString}) async {
    Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw GTecException(
        message: 'nao-foi-possivel-abrir-o-link',
      );
    }
  }
}
