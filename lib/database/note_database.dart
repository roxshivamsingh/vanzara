import "package:sqflite/sqflite.dart";
import "package:sqflite/sqlite_api.dart" as sqflite;
import "package:path/path.dart";

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  NoteDatabase._init();

  static sqflite.Database? _database;

  Future<sqflite.Database> get database async {
    if (_database != null) return database;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<sqflite.Database> _initDB(String filePath) async {
    final dpPath = await getDatabasesPath();
    final path = join(dpPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
}

Future _createDB(sqflite.Database db, int version) async {
  await db.execute('''
CREATE TABLE notes(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT NOT NULL,
description TEXT NOT NULL,
date TEXT NOT NULL,
color INTEGER NOT NULL DEFAULT 0
)
 ''');
}

Future<int> onCreateNotes(
  String title,
  String description,
  String date,
  int color,
) async {
  final db = await NoteDatabase.instance.database;
  return db.insert('notes', {
    'title': title,
    'date': date,
    'description': description,
    'color': color,
  });
}

Future<List<Map<String, dynamic>>> getNotes() async {
  final db = await NoteDatabase.instance.database;

  return await db.query('notes', orderBy: 'date desc');
}

Future<int> updateNotes(
  int id,

  String title,
  String description,
  String date,
  int color,
) async {
  final db = await NoteDatabase.instance.database;
  return await db.update(
    'notes',
    {'title': title, 'date': date, 'description': description, 'color': color},

    where: "id = ?",
    whereArgs: [id],
  );
}

Future<int> deleteNote(int id) async {
  final db = await NoteDatabase.instance.database;
  return await db.delete('notes', where: "id = ?", whereArgs: [id]);
}
