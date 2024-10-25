import 'package:flutter/cupertino.dart';
import 'package:sqlite3/sqlite3.dart';

class UsuarioRepository extends ChangeNotifier{
  //final db = sqlite3.open('C:\\Users\\henri\\Desktop\\Henrique\\Pessoal\\VitalMonitor\\VitalMonitor.db');

  int id = 0;
  String nome = '';
  String senha = '';
  String email = '';
  String telefone = '';
  int idPess = 0;

  UsuarioRepository(){
    int id = 0;
    String nome = '';
    String senha = '';
    String email = '';
    String telefone = '';
    int idPess = 0;
  }

/*
  getUsuarioId(int id) async{
    final db = sqlite3.openInMemory();
    final ResultSet usuario = db.select('select * from usuario where id = ?', [id]);

    _id = usuario.first['id'];
    _nome = usuario.first['nome'];
    _senha = usuario.first['senha'];
    _email = usuario.first['email'];
    _telefone = usuario.first['telefone'];
    _idPess = usuario.first['id_pess'];

    //notifyListeners();
    //print('Artist[id: ${usuario.first['id']}, name: ${usuario.first['nome']}]');
    db.dispose();
    return usuario.first;
  }
*/
  setUsuario(String nome, String senha, String email, String telefone, int idPess, int idUsuario) async{
    final db = sqlite3.openInMemory();
    final stmt = db.prepare('update usuario set ? where ?');
    stmt.execute(['''
      nome = nome,
      senha = senha,
      email = email,
      telefone =  telefone,
      id_pess = idPess,
      ''', 'id = idUsuario']);
/*
    _nome = nome;
    _senha = senha;
    _email = email;
    _telefone = telefone;
    _idPess = idPess;
*/
    stmt.dispose();
    db.dispose();
    notifyListeners();
  }
/*
  createUsuario(String nome, String senha, String email, String telefone, int idPess) async{
    final db = sqlite3.openInMemory();
    final stmt = db.prepare('INSERT INTO usuario (nome, senha, email, telefone, idPess) VALUES (?, ?, ?, ?, ?)');
    stmt.execute([nome, senha, email, telefone, idPess]);

    stmt.dispose();
  }*/
}