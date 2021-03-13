abstract class FontSize {
  final String size = '';
  const FontSize();
}

class ExtraSmallFont extends FontSize {
  const ExtraSmallFont();
  @override
  String get size => 'xs';
}

class SmallFont extends FontSize {
  const SmallFont();
  @override
  String get size => 's';
}

class MediumFont extends FontSize {
  const MediumFont();
  @override
  String get size => 'm';
}

class LargeFont extends FontSize {
  const LargeFont();
  @override
  String get size => 'l';
}
