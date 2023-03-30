import 'package:floor/floor.dart';
import 'package:assignment3/dao/history_dao.dart';
import 'package:assignment3/entity/history.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [History])
abstract class AppDatabase extends FloorDatabase {
  HistoryDAO get historyDAO;
}
