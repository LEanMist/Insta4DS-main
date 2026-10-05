import 'package:flutter/material.dart';
import 'package:instagram_flutter/pages/login_page.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';
import 'package:instagram_flutter/utils/usuario_store.dart';

class CadastroPage extends StatefulWidget{
  const CadastroPage ({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPage();
}

class _CadastroPage extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeUsuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  bool esconderSenha = true;

  Future<void> cadastrar() async {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String nomeUsuario = nomeUsuarioController.text.trim();
    String senha = senhaController.text;
    String confirmarSenha = confirmarSenhaController.text;

    if(nome.isEmpty || email.isEmpty || nomeUsuario.isEmpty || senha.isEmpty || confirmarSenha.isEmpty){
      mostrarMensagem(context, 'Preencha os campos.');
      return;
    }

    if(!UsuarioStore.emailValido(email)){
      mostrarMensagem(context, 'Informe um e-mail válido.');
      return;
    }

    if(senha != confirmarSenha){
      mostrarMensagem(context, 'As senhas não coincidem.');
      return;
    }

    if(!UsuarioStore.cadastrar(
      nome: nome,
      email: email,
      nomeUsuario: nomeUsuario,
      senha: senha,
    )){
      mostrarMensagem(context, 'Este nome de usuário ou e-mail já está cadastrado.');
      return;
    }

    if(!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(usuarioInicial: nomeUsuario),
      ),
    );
    mostrarMensagem(context, 'Cadastro realizado. Faça login para continuar.');
  }

  void login(){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => const LoginPage())
    );
  }

  @override
  void dispose(){
    nomeController.dispose();
    emailController.dispose();
    nomeUsuarioController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nomeController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nomeUsuarioController,
              decoration: const InputDecoration(
                labelText: 'Nome de usuário',
                prefixIcon: Icon(Icons.alternate_email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: senhaController,
              obscureText: esconderSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => esconderSenha = !esconderSenha),
                  icon: Icon(esconderSenha ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: confirmarSenhaController,
              obscureText: esconderSenha,
              decoration: const InputDecoration(
                labelText: 'Confirmar senha',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: cadastrar,
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Cadastrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 138, 186, 231),
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 2),
            TextButton.icon(
              onPressed: login,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar para o login'),
            ),
          ],
        ),
      ),
    );
  }
}