import 'package:short_uuids/short_uuids.dart';

String getId() {
  return const ShortUuid().generate();
}
