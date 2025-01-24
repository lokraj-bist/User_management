import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;


  Future<void> _init() async {
    if (_database == null) {
      final db = join(await getDatabasesPath(), 'example.db');
      _database = await openDatabase(db, version: 1, onCreate: (db, version) {
        db.execute('CREATE TABLE users IF NOT EXISTS (id INTEGER PRIMARY KEY, name TEXT, email TEXT)');
      });
    }
  }


  Future<void> insertUser(Map<String, dynamic> user) async {
    await _init();
    await _database!.insert('users', user);
  }


  Future<List<Map<String, dynamic>>> fetchUsers() async {
    await _init();
    return await _database!.query('users');
  }


  Future<void> deleteUser(int id) async {
    await _init();
    await _database!.delete('users', where: 'id = ?', whereArgs: [id]);
  }


  Future<void> close() async {
    await _database?.close();
  }
}
