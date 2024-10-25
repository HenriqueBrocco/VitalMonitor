import 'package:sqlite3/sqlite3.dart';
import 'package:topicos_4/usuario_repository.dart';

class DB{
  //final db = sqlite3.open('C:\\Users\\henri\\Desktop\\Henrique\\Pessoal\\VitalMonitor\\VitalMonitor.db');
  var db;

  DB(bool inicializar) {
    if(inicializar){
      db = sqlite3.openInMemory();
      _onCreate(db, sqlite3.version);
      print('$inicializar');
    }
  }

  _onCreate(db, versao) async{
    await db.execute(_usuario);
    await db.execute(_pessoa);
    await db.execute(_relacpesssoas);
    await db.execute(_historicomedico);
    //await db.insert('usuario', {});
  }

  String get _usuario => '''
    CREATE TABLE usuario (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      senha TEXT NOT NULL,
      email TEXT NOT NULL,
      telefone TEXT NOT NULL,
      id_pess	INTEGER NOT NULL
    )
  ''';

  String get _pessoa => '''
    CREATE TABLE pessoa (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      cpf TEXT NOT NULL,
      dt_nascimento TEXT NOT NULL,
      prob_saude TEXT,
      alergias TEXT,
      medicamentos TEXT,
      tp_sangue TEXT,
      doador TEXT,
      idioma TEXT,
      deficiencia TEXT,
      plano_saude TEXT,
      nome_emerg TEXT NOT NULL,
      tel_emerg TEXT NOT NULL,
      paren_emerg TEXT NOT NULL,
      endereco_emerg TEXT NOT NULL,
      id_pess_emerg	INTEGER,
      foto BLOB
    )
  ''';

  String get _relacpesssoas => '''
    CREATE TABLE relacpesssoas (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      id_pess_conta	INTEGER NOT NULL,
      id_pess_visualizada	INTEGER NOT NULL
    )
  ''';

  String get _historicomedico => '''
    CREATE TABLE historicomedico (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      id_pess	INTEGER NOT NULL,
      hora TEXT NOT NULL,
      freq_card	INTEGER,
      oxigenacao INTEGER,
      pressao	TEXT ,
      temperatura	REAL
    )
  ''';

  String getUsuarioId(int id) {
    try{
      final ResultSet usuario = db.select('select * from usuario;', []);
      for (final Row row in usuario) {
        print('Artist[id: ${row['id']}, name: ${row['nome']}]');
      }
      var user = UsuarioRepository();
      if(usuario.first.isNotEmpty){
        user.id = usuario.first['id'];
        user.nome = usuario.first['nome'];
        user.senha = usuario.first['senha'];
        user.email = usuario.first['email'];
        user.telefone = usuario.first['telefone'];
        user.idPess = usuario.first['id_pess'];

        return user.nome;
      }
      return '$id';
    } catch(ex){
      return 'Fulano';
    }
    //notifyListeners();
    //print('Artist[id: ${usuario.first['id']}, name: ${usuario.first['nome']}]');
  }

  createUsuario(String nome, String senha, String email, String telefone) async{
    try{
      //Create Pessoa
      //Pega o id gerado
      int idPess = 0;
      final stmt = db.prepare('INSERT INTO usuario (id, nome, senha, email, telefone, id_pess) VALUES (?, ?, ?, ?, ?, ?)');
      stmt.execute([0, nome, senha, email, telefone, idPess]);

      stmt.dispose();
      print(db.select('SELECT nome from usuario'));
    } catch(ex){
        print('excessao $ex');
    }

  }
}