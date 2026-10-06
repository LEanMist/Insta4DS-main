import 'package:flutter/material.dart';
import 'package:instagram_flutter/theme/app_theme.dart';
import 'package:instagram_flutter/widgets/post_instagram.dart';
import 'package:instagram_flutter/widgets/stories.dart';
import '../utils/mensagem_util.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.white,
            title: Text(
              'InstaAula',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 26,
                fontStyle: FontStyle.italic,
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
                  mostrarMensagem(context, 'Você não possui novas mensagens');
                },
                icon: Icon(Icons.send_outlined, color: AppColors.coral),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: Stories()),
          const SliverToBoxAdapter(child: Divider(height: 1)),

          const SliverToBoxAdapter(
            child: PostInstagram(
              usuario: "flutter.dev",
              local: "São Paulo, Brasil",
              legenda: "Construindo interfaces incriveis com Flutter 💓",
              cor: AppColors.blue,
              icone: Icons.flutter_dash,
              curtidasInciais: 128,
            ),
          ),

          const SliverToBoxAdapter(
            child: PostInstagram(
              usuario: "professor.mobile",
              local: "Osasco, Brasil",
              legenda: "Aula de desenvolvimento mobile concluida com sucesso",
              cor: AppColors.purple,
              icone: Icons.school,
              curtidasInciais: 94,
            ),
          ),

          const SliverToBoxAdapter(
            child: PostInstagram(
              usuario: "vitor.dev",
              local: "Carapicuiba, Brasil",
              legenda: "Grau e arte 💓",
              cor: AppColors.coral,
              icone: Icons.code,
              curtidasInciais: 2,
            ),
          ),
        ],
      ),
    );
  }
}
