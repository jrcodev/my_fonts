import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_fonts/app/external/font_repository.dart';
import 'package:my_fonts/app/models/font.dart';
import 'package:my_fonts/app/pages/home/widgets/highlight_text_widget.dart';

class FontListTileWidget extends StatelessWidget {
  final Font font;
  final String highlight;

  const FontListTileWidget({required this.font, this.highlight = ""});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(16),
      child: GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.download_rounded),
                onPressed: () async {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Downloading...")));
                  final result =
                      await GetIt.I.get<FontRepository>().save(font: font);

                  ScaffoldMessenger.of(context).showSnackBar(result.fold(
                    (_) => SnackBar(content: Text("An error has occurred!")),
                    (_) => SnackBar(content: Text("Font installed")),
                  ));
                },
                tooltip: "Download",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HighlightText(
                      text: font.title,
                      highlight: highlight,
                      color: Theme.of(context).accentColor),
                  Text(
                    "by ${font.author}",
                    style: TextStyle(color: Colors.black.withOpacity(.6)),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              font.preview,
                              fit: BoxFit.fitWidth,
                            )),
                      ],
                    ),
                  ),
                  Text(
                    font.info,
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              )
            ],
          )),
    );
  }
}
