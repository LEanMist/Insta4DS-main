import 'package:flutter/material.dart';
import 'package:instagram_flutter/pages/login_page.dart';
import 'package:instagram_flutter/utils/usuario_store.dart';
import 'editar_perfil_page.dart';

import '../utils/mensagem_util.dart';
import '../widgets/numero_perfil.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  void sair(BuildContext context) {
    UsuarioStore.sair();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
  
  Future<void> abrirEditarPerfil(BuildContext context) async {
    final atualizado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const EditarPerfilPage()),
    );
    if(!mounted || atualizado != true) return;

    setState(() {});
    mostrarMensagem(context, 'Dados atualizados.');
  }

  @override
  Widget build(BuildContext context) {
    final usuario = UsuarioStore.usuarioLogado;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            title: Text(
              '@${usuario?.nomeUsuario ?? 'perfil'}',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  mostrarMensagem(context, 'Criar publicação');
                },
                icon: const Icon(Icons.add_box_outlined),
              ),
              IconButton(
                onPressed: () {
                  mostrarMensagem(context, 'Abrir menu');
                },
                icon: const Icon(Icons.menu),
              ),
              IconButton(
                onPressed: () => sair(context),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.deepPurple,
                        child: usuario != null && usuario.nome.trim().isNotEmpty
                            ? Text(
                                usuario.nome.trim()[0].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Icon(Icons.person, color: Colors.white, size: 48),
                      ),
                      SizedBox(width: 24),
                      Expanded(child: NumeroPerfil(numero: '9', rotulo: 'publicações')),
                      Expanded(child: NumeroPerfil(numero: '1.250', rotulo: 'seguidores')),
                      Expanded(child: NumeroPerfil(numero: '380', rotulo: 'seguindo')),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    usuario?.nome ?? 'Nome não disponível',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('E-mail: ${usuario?.email ?? 'não disponível'}'),
                  if(usuario?.biografia.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(usuario!.biografia),
                    ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => abrirEditarPerfil(context),
                      child: const Text('Editar perfil'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Padding(padding: EdgeInsets.all(12), child: Icon(Icons.grid_on)),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.person_pin_outlined, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, indice) {
                final cores = [
                  Colors.deepPurple, Colors.pink, Colors.blue, Colors.orange, Colors.teal,
                ];

                return Container(
                  color: cores[indice % cores.length],
                  child: const Icon(Icons.flutter_dash, color: Colors.white, size: 42),
                );
              },
              childCount: 9,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
            ),
          ),
        ],
      ),
    );
  }
}