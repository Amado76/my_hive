String formatHtml(String htmlString) {
  // Substitui quebras de linha HTML por quebras de linha reais
  String noHtml = htmlString
      .replaceAll('<br>', '\n')
      .replaceAll('<br/>', '\n')
      .replaceAll('<br />', '\n');

  // Remove todas as outras tags HTML (simplesmente remove as tags, não aplica estilos)
  noHtml = noHtml.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');

  // Substitui entidades HTML comuns
  noHtml = noHtml.replaceAll('&nbsp;', ' ');
  noHtml = noHtml.replaceAll('&amp;', '&');
  noHtml = noHtml.replaceAll('&lt;', '<');
  noHtml = noHtml.replaceAll('&gt;', '>');

  return noHtml;
}
