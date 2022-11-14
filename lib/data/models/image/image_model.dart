class ImageModel {
  final String id;
  String path;

  ImageModel({
    required this.id,
    required this.path,
  });

  void changePath(String value) {
    path = value;
  }
}
