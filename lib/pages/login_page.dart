import 'package:flutter/material.dart';
import 'package:instagram_flutter/pages/home_page.dart';
import 'package:instagram_flutter/pages/recuperacao_senha_page.dart';
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
      appBar: AppBar(
        title: const Text(
              'InstaAula',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40,),

            const Icon(
              Icons.flutter_dash,
              size: 100,
            ),

            const SizedBox(height: 20,),

            Text(
              'Bem vindo', 
              textAlign: TextAlign.center, 
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 30,),

            TextField(
              controller: usuarioController,
              decoration: const InputDecoration(
                hintText: 'Entre com o seu usuário',
                labelText: 'Usuário',
                prefixIcon: Icon(Icons.alternate_email),
                border: OutlineInputBorder(),
              ),
            ),
 
            const SizedBox(height: 15,),

            TextField(
              controller: senhaController,
              obscureText: esconderSenha,
              decoration: InputDecoration(
                hintText: 'Entre com a sua senha',
                labelText: 'Senha',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  }, 
                  icon: Icon(
                    esconderSenha ? Icons.visibility : Icons.visibility_off
                  )
                ),
              ),
            ),

            const SizedBox(height: 17,),

            ElevatedButton.icon(
              onPressed: () async {
                if (await entrar()) abrirHome();
              },
              icon: const Icon(Icons.login),
              label: const Text('Entrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 138, 186, 231),
                foregroundColor: Colors.black
              ),
            ),

            const SizedBox(height: 7,),

            ElevatedButton.icon(
              onPressed: abriCadastro,
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Cadastrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 138, 186, 231),
                foregroundColor: Colors.black
              ),
            ),
            TextButton(
              onPressed: abrirRecuperacaoSenha,
              child: const Text('Esqueci minha senha'),
            ),
          ],
        ),
      ),
    );
  }
}