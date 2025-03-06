import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// mengelola koneksi database
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

// mengakses dan membuat database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

// inisialisasi database dan lokasi
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath(); // lokasi penyimpanan database
    final path = join(dbPath, filePath); //menggabungkan path database

    return await openDatabase(path,
        version: 1,
        onCreate:
            _createDB); //membuka database, kalau belum ada memanggil _createDB
  }

// membuat tabel users
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        phone TEXT,
        address TEXT,
        gender TEXT,
        religion TEXT,
        birthdate TEXT,
        password TEXT
      )
    '''); //fungsi yang digunakan untuk menjalankan SQFLite. string dalam dart, kode SQL lebih mudah dibaca
  }

// menyimpan data
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

// mengambil data sesuai username
  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await instance.database;
    final result =
        await db.query('users', where: 'username = ?', whereArgs: [username]);
    return result.isNotEmpty ? result.first : null;
  }
}
