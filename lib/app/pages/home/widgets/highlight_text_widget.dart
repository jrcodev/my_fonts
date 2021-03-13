import 'package:flutter/material.dart';

class SplitHighlight {
  final String firstPart, secondPart, highlight;

  const SplitHighlight.withouHighlight({
    required this.firstPart,
    this.secondPart = "",
    this.highlight = "",
  });

  const SplitHighlight.withHighlight({
    required this.firstPart,
    required this.secondPart,
    required this.highlight,
  });

  @override
  String toString() =>
      'SplitHighlight(highlight: $highlight, firstPart: $firstPart, secondPart: $secondPart)';
}

class HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final Color color;

  const HighlightText({
    required this.text,
    required this.highlight,
    required this.color,
  });

  static const kTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    final split = splitText(text, highlight);
    return RichText(
        text: TextSpan(children: [
      if (split.highlight.isEmpty) ...[
        TextSpan(text: split.firstPart, style: kTextStyle)
      ],
      if (split.highlight.isNotEmpty) ...[
        TextSpan(text: split.firstPart, style: kTextStyle),
        TextSpan(
          text: split.highlight,
          style: kTextStyle.copyWith(color: color),
        ),
        TextSpan(text: split.secondPart, style: kTextStyle)
      ]
    ]));
  }

  SplitHighlight splitText(String text, String highlight) {
    final startIndex = text.toLowerCase().lastIndexOf(highlight.toLowerCase());

    if (startIndex == -1) {
      return SplitHighlight.withouHighlight(firstPart: text);
    }
    final partOne = text.substring(0, startIndex);
    final highLight = text.substring(startIndex, startIndex + highlight.length);
    final partTwo = text.substring(startIndex + highlight.length);
    return SplitHighlight.withHighlight(
      firstPart: partOne,
      secondPart: partTwo,
      highlight: highLight,
    );
  }
}
