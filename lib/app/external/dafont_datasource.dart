import 'package:web_scraper/web_scraper.dart';

import 'package:my_fonts/app/data/font_datasource.dart';
import 'package:my_fonts/app/models/font.dart';
import 'package:my_fonts/app/models/font_size.dart';

class BaseUrl {
  final baseUrl = 'https://www.dafont.com';

  String call(Map<String, dynamic> params) {
    params.removeWhere((key, value) => value == null);
    params.forEach((key, value) {
      if (key == 'page' || key == 'fpp') {
        params[key] = params[key].toString();
      }
    });
    var query = Uri(queryParameters: params).query;
    print(query);
    return '/search.php?$query';
  }

  String concat({required String route}) {
    return '$baseUrl$route';
  }
}

class DataExtraction {
  final indexesSelector = 'div.noindex > a';
  final linkSelector = 'div.dlbox > a.dl';
  final titleSelector = 'div.lv1left.dfbg';
  final styleSelector = 'div.preview';
  final infoSelector = 'span.light';

  List<Font> call({required WebScraper scraper, int page = 1}) {
    final indexes = scraper.getElement(indexesSelector, []);

    if (indexes.isNotEmpty) {
      final index = indexes.lastWhere(
          (element) => element['title'].toString().isNotEmpty)['title'];
      if (page > int.parse(index)) {
        return <Font>[];
      }
    }

    final links = scraper
        .getElement(linkSelector, ['href'])
        .map((map) => map['attributes']['href'])
        .toList();

    final titles = scraper
        .getElement(titleSelector, [])
        .map((map) => map['title'])
        .toList();

    final styles = scraper
        .getElement(styleSelector, ['style'])
        .map((map) => map['attributes']['style'].split(RegExp(r'[()]')))
        .map((e) => e[1])
        .toList();

    final infos = scraper
        .getElement(infoSelector, [])
        .map((map) => map['title'])
        .map((info) => info.split("(").first.trim())
        .toList();

    return List.generate(links.length, (i) {
      var title = titles[i];
      final List<String> titleAuthorSplit = title.split('by');
      var fontTitle =
          titleAuthorSplit[0].toString().split(RegExp(r'[à€]')).first;

      var author;

      try {
        author = titleAuthorSplit.elementAt(1);
      } on RangeError {
        author = '';
      }

      return Font(
        title: fontTitle,
        link: links[i],
        author: author,
        preview: styles[i],
        info: infos[i],
      );
    });
  }
}

class ExtractedDataFormat {
  final https = 'https:';
  List<Font> call(List<Font> fonts) {
    return fonts
        .map((font) => font.copyWith(
            link: https + font.link,
            preview: font.preview.startsWith('//')
                ? https + font.preview
                : BaseUrl().concat(route: font.preview)))
        .toList();
  }
}

class DafontDatasource implements FontDatasource {
  final query = BaseUrl();
  final extract = DataExtraction();
  final format = ExtractedDataFormat();
  late final scraper = WebScraper(query.baseUrl);

  @override
  Future<List<Font>> search(
    String font, {
    String? previewText,
    int? page,
    int? quantity,
    FontSize? size,
  }) async {
    final params = {
      'q': font,
      'text': previewText,
      'page': page,
      'fpp': quantity,
      'psize': size?.size
    };
    final success = await scraper.loadWebPage(query(params));

    if (success) {
      final data = format(extract(scraper: scraper, page: page!));
      return data;
    } else {
      throw Exception();
    }
  }
}
