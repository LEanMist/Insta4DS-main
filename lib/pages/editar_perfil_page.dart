import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';
import 'package:instagram_flutter/utils/usuario_store.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nomeController;
  late final TextEditingController nomeUsuarioController;
  late final TextEditingController biografiaController;

  @override
  void initState(){
    super.initState();
    final usuario = UsuarioStore.usuarioLogado;
    nomeController = TextEditingController(text: usuario?.nome ?? '');
    nomeUsuarioController = TextEditingController(text: usuario?.nomeUsuario ?? '');
    biografiaController = TextEditingController(text: usuario?.biografia ?? '');
  }

  void salvar(){
    if(!_formKey.currentState!.validate()) return;

    final atualizado = UsuarioStore.atualizarPerfil(
      nome: nomeController.text,
      nomeUsuario: nomeUsuarioController.text,
      biografia: biografiaController.text,
    );

    if(!atualizado){
      mostrarMensagem(context, 'Este nome de usuário já está em uso.');
      return;
    }

    Navigator.pop(context, true);
  }

  @override
  void dispose(){
    nomeController.dispose();
    nomeUsuarioController.dispose();
    biografiaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) => valor == null || valor.trim().isEmpty
                    ? 'Informe seu nome.'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nomeUsuarioController,
                decoration: const InputDecoration(
                  labelText: 'Nome de usuário',
                  prefixText: '@',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) => valor == null || valor.trim().isEmpty
                    ? 'Informe seu nome de usuário.'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: biografiaController,
                maxLines: 3,
                maxLength: 150,
                decoration: const InputDecoration(
                  labelText: 'Biografia',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: salvar,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Salvar alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}