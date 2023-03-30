import 'package:floor/floor.dart';

@entity
class History {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String items;

  History({required this.items, this.id});
}
