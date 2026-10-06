import 'package:flutter/material.dart';
import 'package:instagram_flutter/pages/login_page.dart';
import 'package:instagram_flutter/theme/app_theme.dart';
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
    final messenger = ScaffoldMessenger.maybeOf(context);
    final atualizado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const EditarPerfilPage()),
    );
    if(!mounted || atualizado != true) return;

    setState(() {});
    messenger?.showSnackBar(
      const SnackBar(content: Text('Dados atualizados.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = UsuarioStore.usuarioLogado;
    final nome = usuario?.nome.trim() ?? '';
    final inicial = nome.isEmpty ? null : nome.substring(0, 1).toUpperCase();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            title: Text(
              '@${usuario?.nomeUsuario ?? 'perfil'}',
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  mostrarMensagem(context, 'Criar publicação');
                },
                icon: Icon(Icons.add_box_outlined, color: AppColors.purple),
              ),
              IconButton(
                onPressed: () {
                  mostrarMensagem(context, 'Abrir menu');
                },
                icon: Icon(Icons.menu, color: AppColors.coral),
              ),
              IconButton(
                onPressed: () => sair(context),
                icon: Icon(Icons.logout, color: AppColors.purpleDark),
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
                        backgroundColor: AppColors.purple,
                        child: inicial != null
                            ? Text(
                                inicial,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            : const Icon(Icons.person, color: AppColors.white, size: 48),
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
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'E-mail: ${usuario?.email ?? 'não disponível'}',
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  if(usuario?.biografia.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        usuario!.biografia,
                        style: const TextStyle(color: AppColors.ink),
                      ),
                    ),
                  const SizedBox(height: 16),
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
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.grid_on, color: AppColors.purple),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.person_pin_outlined, color: AppColors.coral),
                  ),
                ),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, indice) {
                final cores = [
                  AppColors.purple,
                  AppColors.coral,
                  AppColors.blue,
                  AppColors.purpleDark,
                  AppColors.navy,
                ];

                return Container(
                  decoration: BoxDecoration(
                    color: cores[indice % cores.length],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.flutter_dash, color: AppColors.white, size: 42),
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