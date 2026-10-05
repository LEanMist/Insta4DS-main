class UsuarioStore {
  static final Map<String, Usuario> _usuarios = {};
  static Usuario? usuarioLogado;

  static bool emailValido(String email){
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email.trim());
  }

  static bool cadastrar({
    required String nome,
    required String email,
    required String nomeUsuario,
    required String senha,
  }){
    final chave = nomeUsuario.trim().toLowerCase();
    final emailNormalizado = email.trim().toLowerCase();
    if(_usuarios.containsKey(chave) ||
        _usuarios.values.any((usuario) => usuario.email.toLowerCase() == emailNormalizado)) {
      return false;
    }

    _usuarios[chave] = Usuario(
      nome: nome.trim(),
      email: email.trim(),
      nomeUsuario: nomeUsuario.trim(),
      senha: senha,
    );
    return true;
  }

  static bool atualizarPerfil({
    required String nome,
    required String nomeUsuario,
    required String biografia,
  }){
    final usuario = usuarioLogado;
    if(usuario == null) return false;

    final novaChave = nomeUsuario.trim().toLowerCase();
    final usuarioExistente = _usuarios[novaChave];
    if(usuarioExistente != null && !identical(usuarioExistente, usuario)) {
      return false;
    }

    _usuarios.remove(usuario.nomeUsuario.toLowerCase());
    usuario.nome = nome.trim();
    usuario.nomeUsuario = nomeUsuario.trim();
    usuario.biografia = biografia.trim();
    _usuarios[novaChave] = usuario;
    return true;
  }

  static bool autenticar(String nomeUsuario, String senha){
    final usuario = _usuarios[nomeUsuario.trim().toLowerCase()];
    if(usuario == null || !usuario.confereSenha(senha)) return false;

    usuarioLogado = usuario;
    return true;
  }

  static void sair(){
    usuarioLogado = null;
  }
}

class Usuario {
  Usuario({
    required String nome,
    required this.email,
    required String nomeUsuario,
    required String senha,
    this.biografia = '',
  }) : nome = nome.trim(),
       nomeUsuario = nomeUsuario.trim(),
       _senha = senha;

  String nome;
  final String email;
  String nomeUsuario;
  String biografia;
  final String _senha;

  bool confereSenha(String senha) => _senha == senha;
}