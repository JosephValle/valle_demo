import "dart:async";
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "../../objects/repo_object.dart";
import "../../utilities/const/constant.dart";

class DataBaseService {
  static final DataBaseService _instance = DataBaseService._internal();

  factory DataBaseService() => _instance;

  DataBaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the database
    _database = await _initDB("repos.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const String tableRepos = "repos";
    await db.execute("""
      CREATE TABLE $tableRepos (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        html_url TEXT NOT NULL,
        created_at TEXT NOT NULL,
        pushed_at TEXT NOT NULL,
        description TEXT,
        stargazers_count INTEGER NOT NULL
      )
    """);
  }

  // Insert or Replace RepoObject
  Future<void> insertRepo(RepoObject repo) async {
    final db = await database;
    await db.insert(
      "repos",
      repo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert multiple repositories in a batch
  Future<void> insertRepos(List<RepoObject> repos) async {
    final db = await database;
    final Batch batch = db.batch();
    for (final repo in repos) {
      batch.insert(
        "repos",
        repo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // Retrieve all repositories
  Future<List<RepoObject>> getAllRepos({
    required int page,
    int count = Constants.queryCount,
  }) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "repos",
      limit: count,
      offset: page * count,
    );

    return List.generate(maps.length, (i) {
      return RepoObject.fromJson(maps[i]);
    });
  }

  // Clear all repositories
  Future<void> clearRepos() async {
    final db = await database;
    await db.delete("repos");
  }
}
