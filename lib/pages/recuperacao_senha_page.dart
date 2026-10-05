import 'package:flutter/material.dart';
import 'package:instagram_flutter/pages/login_page.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';
import 'package:instagram_flutter/utils/usuario_store.dart';

class RecuperacaoSenhaPage extends StatefulWidget {
	const RecuperacaoSenhaPage({super.key});

	@override
	State<RecuperacaoSenhaPage> createState() => _RecuperacaoSenhaPageState();
}

class _RecuperacaoSenhaPageState extends State<RecuperacaoSenhaPage> {
	final TextEditingController emailController = TextEditingController();
	bool solicitacaoRealizada = false;

	void recuperarSenha(){
		if(emailController.text.trim().isEmpty){
			setState(() => solicitacaoRealizada = false);
			mostrarMensagem(context, 'Informe seu e-mail.');
			return;
		}

		if(!UsuarioStore.emailValido(emailController.text)){
			setState(() => solicitacaoRealizada = false);
			mostrarMensagem(context, 'Informe um e-mail válido.');
			return;
		}

		setState(() => solicitacaoRealizada = true);
	}

	void voltarLogin(){
		Navigator.pushReplacement(
			context,
			MaterialPageRoute(builder: (context) => const LoginPage()),
		);
	}

	@override
	void dispose(){
		emailController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(title: const Text('Recuperar senha')),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(24),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						const Text(
							'Informe o e-mail usado no cadastro.',
							style: TextStyle(fontSize: 16),
						),
						const SizedBox(height: 20),
						TextField(
							controller: emailController,
							keyboardType: TextInputType.emailAddress,
							decoration: const InputDecoration(
								labelText: 'E-mail',
								prefixIcon: Icon(Icons.email_outlined),
								border: OutlineInputBorder(),
							),
							onChanged: (_) {
								if(solicitacaoRealizada) {
									setState(() => solicitacaoRealizada = false);
								}
							},
						),
						const SizedBox(height: 16),
						ElevatedButton.icon(
							onPressed: recuperarSenha,
							icon: const Icon(Icons.lock_reset),
							label: const Text('Recuperar senha'),
						),
						if(solicitacaoRealizada) ...[
							const SizedBox(height: 16),
							const Text(
								'Solicitação de recuperação realizada.',
								textAlign: TextAlign.center,
							),
						] else if(emailController.text.isEmpty) ...[
							const SizedBox(height: 8),
							const Text(
								'Digite seu e-mail para solicitar a recuperação.',
								textAlign: TextAlign.center,
								style: TextStyle(color: Colors.grey),
							),
						],
						const SizedBox(height: 12),
						TextButton.icon(
							onPressed: voltarLogin,
							icon: const Icon(Icons.arrow_back),
							label: const Text('Voltar para o login'),
						),
					],
				),
			),
		);
	}
}
