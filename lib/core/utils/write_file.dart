import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

Future<String> writeFile(
  String name,
  String content,
) async {
  final directory = await getApplicationDocumentsDirectory();

  final filePath = '${directory.path}/$name';

  final file = File(filePath);

  await file.writeAsString(content);

  return filePath;
}
