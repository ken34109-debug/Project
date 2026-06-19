import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'smart_lock.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');
        
       
        await db.execute('''
          CREATE TABLE activity_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user TEXT,
            status TEXT,
            date TEXT,
            time TEXT
          )
        ''');
      },
    );
  }

 

  Future<int> registerUser(String user, String pass) async {
    final db = await database;
    try {
      return await db.insert('users', {'username': user, 'password': pass});
    } catch (e) {
      return -1; 
    }
  }

  Future<bool> loginUser(String user, String pass) async {
    final db = await database;
    List<Map> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [user, pass],
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<int> deleteUser(String username) async {
    final db = await database;
    return await db.delete('users', where: 'username = ?', whereArgs: [username]);
  }

  Future<int> updateUsername(String oldName, String newName) async {
    final db = await database;
    return await db.update('users', {'username': newName},
        where: 'username = ?', whereArgs: [oldName]);
  }

  Future<int> updatePassword(String username, String newPass) async {
    final db = await database;
    return await db.update('users', {'password': newPass},
        where: 'username = ?', whereArgs: [username]);
  }

  
  Future<int> insertLog(String user, String status) async {
    final db = await database;
    DateTime now = DateTime.now();
    
    
    String date = "${now.day}/${now.month}/${now.year}";
    String time = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

    return await db.insert('activity_logs', {
      'user': user,
      'status': status,
      'date': date,
      'time': time,
    });
  }

 
  Future<List<Map<String, dynamic>>> getAllLogs() async {
    final db = await database;
    
    return await db.query('activity_logs', orderBy: 'id DESC');
  }

  
  Future<int> clearLogs() async {
    final db = await database;
    return await db.delete('activity_logs');
  }
}