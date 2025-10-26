import 'package:isar/isar.dart';


// then run: dart run build_runner build
part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
