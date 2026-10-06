import 'package:flutter/material.dart';
import 'package:instagram_flutter/pages/home_page.dart';
import 'package:instagram_flutter/pages/recuperacao_senha_page.dart';
import 'package:instagram_flutter/theme/app_theme.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';
import 'package:instagram_flutter/utils/usuario_store.dart';
import 'cadastro_page.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key, this.usuarioInicial = ''});

  final String usuarioInicial;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  late final TextEditingController usuarioController;
  final TextEditingController senhaController = TextEditingController();

  bool esconderSenha = true;

  @override
  void initState(){
    super.initState();
    usuarioController = TextEditingController(text: widget.usuarioInicial);
  }

  Future<bool> entrar() async {
    String usuario = usuarioController.text.trim();
    String senha = senhaController.text;

    if(usuario.isEmpty || senha.isEmpty){
      mostrarMensagem(context, 'Preencha os campos.');
      return false;
    }

    if(!UsuarioStore.autenticar(usuario, senha)){
      mostrarMensagem(context, 'Usuário ou senha inválidos.');
      return false;
    }

    return true;
  }

  void abriCadastro(){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => const CadastroPage())
    );
  }

  void abrirRecuperacaoSenha(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RecuperacaoSenhaPage()),
    );
  }

  void abrirHome(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage())
    );
  }

  @override
  void dispose(){
    usuarioController.dispose();
    senhaController.dispose();

    super.dispose();
  }
    
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.coral, AppColors.purple],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purple.withValues(alpha: 0.28),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(Icons.flutter_dash, size: 64, color: AppColors.white),
              ),

              const SizedBox(height: 24),

              Text(
                'Bem vindo!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 30,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Entre para continuar sua jornada.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 32),
              TextField(
                controller: usuarioController,
                decoration: const InputDecoration(
                  hintText: 'Entre com o seu usuário',
                  labelText: 'Usuário',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: senhaController,
                obscureText: esconderSenha,
                decoration: InputDecoration(
                  hintText: 'Entre com a sua senha',
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        esconderSenha = !esconderSenha;
                      });
                    },
                    icon: Icon(
                      esconderSenha ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.muted,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: () async {
                  if (await entrar()) abrirHome();
                },
                icon: const Icon(Icons.login),
                label: const Text('Entrar'),
              ),

              const SizedBox(height: 10),

              OutlinedButton.icon(
                onPressed: abriCadastro,
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text('Cadastrar'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: abrirRecuperacaoSenha,
                child: const Text('Esqueci minha senha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}