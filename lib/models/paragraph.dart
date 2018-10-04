class Paragraph {
  String title;
  List<ParagraphItem> items;
  Paragraph(this.title, this.items);
}

class ParagraphItem {
  String text;
  List<String> images;
  ParagraphItem(this.text, this.images);
}
