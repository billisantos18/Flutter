import 'package:bitycode/dao/Contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactDao.tablesql);
  }, version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}