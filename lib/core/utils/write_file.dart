import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

Future<String> writeFile(
  String name,
  Uint8List bytes,
) async {
  final directory = await getApplicationDocumentsDirectory();

  final filePath = '${directory.path}/$name';

  final file = File(filePath);

  final exists = await file.exists();

  if (!exists) {
    await file.writeAsBytes(bytes);
  }

  return filePath;
}
