import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "First.db";
  static final _userTable = "user";
  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database ??= await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE user(id INTEGER PRIMARY KEY ,name TEXT NOT NULL,lastName TEXT, isActive INTEGER NOT NULL)');
    if (version > 1) {
      _onUpgrade(db, 1, version);
    }

    print("Create Tables");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2 || newVersion == 2) {
      await db.execute("ALTER TABLE user add lastName TEXT");
    }

    print(
        "Old Version: ${oldVersion.toString()} / New Version: ${newVersion.toString()}");
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), ""),
      onCreate: (db, version) {
        return db.execute("");
      },
      version: 1,
    );
  }

  // métodos Helper
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(Map<String, dynamic> row) async {
    try {
      Database? db = await instance.database;
      return await db!.insert(_userTable, row);
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(_userTable);
  }

  // Todos os métodos : inserir, consultar, atualizar e excluir,
  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $_userTable'));
  }

  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.
  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row['id'];
    return await db!.update(_userTable, row, where: 'id = ?', whereArgs: [id]);
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_userTable, where: 'id = ?', whereArgs: [id]);
  }
}
