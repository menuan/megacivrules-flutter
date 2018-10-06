class Paragraph {
  String title;
  List<ParagraphItem> items;
  Paragraph(this.title, this.items);

  Paragraph.fromJSON(Map<String, dynamic> json) : title = json['title'] {
    this.items = List.from((json["items"] as List))
        .map((itemJson) => ParagraphItem.fromJSON(itemJson))
        .toList();
  }
}

class ParagraphItem {
  String text;
  List<String> images;
  ParagraphItem(this.text, this.images);

  ParagraphItem.fromJSON(Map<String, dynamic> json) : text = json['text'] {
    print(json["images"]);
    if (json["images"] == null) {
      this.images = [];
    } else {
      this.images = List.from((json["images"] as List))
          .map((src) => src as String)
          .toList();
    }
  }
}
