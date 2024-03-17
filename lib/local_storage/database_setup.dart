import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DatabaseSetup {
  static final DatabaseSetup databaseSetup = DatabaseSetup._internal();
  static Box? meetsBox;
  factory DatabaseSetup() {
    return databaseSetup;
  }

  DatabaseSetup._internal();

  static initDatabase ()async {
    await Hive.initFlutter();
    meetsBox = await Hive.openBox('meetsBox');
  }
}