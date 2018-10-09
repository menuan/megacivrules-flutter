import 'dart:typed_data';
import 'dart:convert';

class ImageCache {
  static ImageCache instance = ImageCache();

  Map<String, Uint8List> _images = Map();

  void setImage(String key, String base64String) {
    _images[key] = Base64Decoder().convert(base64String);
  }

  Uint8List getImage(String key) {
    return _images[key];
  }
}
