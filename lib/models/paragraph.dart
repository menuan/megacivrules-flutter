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
  List<PunctuatedList> punctuatedTextList;
  List<String> images;
  ParagraphItem(this.text, this.images, this.punctuatedTextList);

  ParagraphItem.fromJSON(Map<String, dynamic> json) : text = json['text'] {
    if (json["images"] == null) {
      this.images = [];
    } else {
      this.images = List.from((json["images"] as List))
          .map((src) => src as String)
          .toList();
    }
    if (json["punctuatedTextList"] != null) {
      this.punctuatedTextList = List.from((json["punctuatedTextList"] as List))
          .map((p) => PunctuatedList.fromJSON(p))
          .toList();
    }
  }
}

class PunctuatedList {
  String title;
  String text;
  List<PunctuatedListItem> items;
  PunctuatedList({this.title, this.text, this.items});

  PunctuatedList.fromJSON(Map<String, dynamic> json)
      : title = json["title"],
        text = json["text"] {
    if (json["items"] != null) {
      this.items = List.from((json["items"] as List))
          .map((p) => PunctuatedListItem.fromJSON(p))
          .toList();
    } else {
      this.items = [];
    }
  }
}

class PunctuatedListItem {
  String text;
  String title;
  String leading;

  PunctuatedListItem({this.text, this.title, this.leading});

  PunctuatedListItem.fromJSON(Map<String, dynamic> json)
      : text = json['text'],
        title = json['title'],
        leading = json['leading'];
}
