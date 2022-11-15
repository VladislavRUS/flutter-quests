import 'load_asset.dart';
import 'write_file.dart';

Future<String> writeAssetFile(String assetPath, String fileName) async {
  final bytes = await loadAsset(assetPath);

  return writeFile(fileName, bytes);
}
