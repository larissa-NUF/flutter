class Usuario {
  int id;
  String nome;
  String email;
  String senha;
  String login;
  String tipo;
  DateTime dataCadastro;

  Usuario(
      {this.id = 0,
      this.nome = "",
      this.email = "",
      this.senha = "",
      this.login = "",
      this.tipo = "",
      DateTime? dataCadastro})
      : this.dataCadastro = dataCadastro ?? DateTime.now();

  factory Usuario.fromJson(Map<dynamic, dynamic> json) {
    Usuario user = new Usuario();
    user.id = int.parse(json['id']);
    user.nome = json['nome'];
    user.email = json['email'];
    user.senha = json['senha'];
    user.login = json['login'];
    user.tipo = json['tipo'];
    user.dataCadastro = DateTime.parse(json['dataCadastro']);
    return user;
  }
}
