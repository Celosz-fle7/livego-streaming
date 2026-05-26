import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/livego.db';
    return await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        drama_id TEXT NOT NULL UNIQUE,
        drama_title TEXT NOT NULL,
        drama_poster TEXT,
        episode INTEGER DEFAULT 1,
        platform TEXT NOT NULL,
        watched_at INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        drama_id TEXT NOT NULL UNIQUE,
        drama_title TEXT NOT NULL,
        drama_poster TEXT,
        platform TEXT NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');
    await db.execute('CREATE INDEX idx_history_drama_id ON history(drama_id)');
    await db.execute('CREATE INDEX idx_favorites_drama_id ON favorites(drama_id)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      try { await db.execute('ALTER TABLE history ADD COLUMN episode INTEGER DEFAULT 1'); } catch (e) {}
    }
  }

  // HISTORY
  Future<void> addToHistory({required String dramaId, required String dramaTitle, required String dramaPoster, required String platform, int episode = 1}) async {
    final db = await database;
    await db.insert('history', {
      'drama_id': dramaId,
      'drama_title': dramaTitle,
      'drama_poster': dramaPoster,
      'platform': platform,
      'episode': episode,
      'watched_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return await db.query('history', orderBy: 'watched_at DESC');
  }

  Future<void> clearHistory() async {
    final db = await database;
    await db.delete('history');
  }

  Future<void> removeFromHistory(String dramaId) async {
    final db = await database;
    await db.delete('history', where: 'drama_id = ?', whereArgs: [dramaId]);
  }

  // FAVORITES
  Future<void> addToFavorites({required String dramaId, required String dramaTitle, required String dramaPoster, required String platform}) async {
    final db = await database;
    await db.insert('favorites', {
      'drama_id': dramaId,
      'drama_title': dramaTitle,
      'drama_poster': dramaPoster,
      'platform': platform,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFromFavorites(String dramaId) async {
    final db = await database;
    await db.delete('favorites', where: 'drama_id = ?', whereArgs: [dramaId]);
  }

  Future<void> removeFavorite(String dramaId) async => removeFromFavorites(dramaId);

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites', orderBy: 'created_at DESC');
  }

  Future<bool> isFavorite(String dramaId) async {
    final db = await database;
    final result = await db.query('favorites', where: 'drama_id = ?', whereArgs: [dramaId]);
    return result.isNotEmpty;
  }

  Future<void> clearFavorites() async {
    final db = await database;
    await db.delete('favorites');
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('history');
    await db.delete('favorites');
  }
}
