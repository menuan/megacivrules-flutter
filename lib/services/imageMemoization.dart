import 'dart:typed_data';

class ImageMemoization {
  static ImageMemoization instance = ImageMemoization();
  ImageMemoization();

  Map<String, Uint8List> _images = Map();

  void setImage(String key, Uint8List image) {
    _images[key] = image;
  }

  Uint8List getImage(String key) {
    return _images[key];
  }
}
