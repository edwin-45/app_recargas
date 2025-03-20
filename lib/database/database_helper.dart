import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'recargas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recargas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            proveedor TEXT,
            telefono TEXT,
            monto INTEGER,
            fecha TEXT
          )
        ''');
      },
    );
  }

  // Guardar una recarga
  Future<int> insertRecarga(Map<String, dynamic> recarga) async {
    final db = await database;
    return await db.insert('recargas', recarga);
  }

  // Obtener todas las recargas
  Future<List<Map<String, dynamic>>> getRecargas() async {
    final db = await database;
    return await db.query('recargas', orderBy: "fecha DESC");
  }

  // Eliminar todas las recargas
  Future<void> deleteAllRecargas() async {
    final db = await database;
    await db.delete('recargas');
  }
}
