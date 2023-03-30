import 'package:floor/floor.dart';
import 'package:assignment3/entity/history.dart';

@dao
abstract class HistoryDAO {
  @Query("SELECT * FROM History")
  Stream<List<History>> getAllHistory();

  @Query("SELECT * FROM History WHERE id=:id")
  Stream<History?> getAllHistoryById(int id);

  @Query("DELETE FROM History")
  Future<void> deleteAllEmployee();

  @insert
  Future<void> insertHistory(History history);

  @delete
  Future<void> deleteHistory(History history);
}
