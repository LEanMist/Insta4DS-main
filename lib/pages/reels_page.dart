import 'package:flutter/material.dart';
import 'package:instagram_flutter/theme/app_theme.dart';
import 'package:instagram_flutter/widgets/botao_reel.dart';
import '../utils/mensagem_util.dart';

class ReelsPage  extends StatelessWidget{
  const ReelsPage({super.key});

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.purpleDark, AppColors.navy],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Icon(Icons.play_circle, color: AppColors.white, size: 120),
          ),
          const Positioned(
            top: 16,
            left: 16,
            child: Text(
              'Reels',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            left: 16,
            right: 80,
            bottom: 24,
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@flutter.dev',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Aprendendo Flutter de uma forma simples e prática',
                  style: TextStyle(color: AppColors.white),
                )
              ],
            )
          ),
          Positioned(
            right: 12,
            bottom: 24,
            child: Column(
              children: [
                BotaoReel(
                  icone: Icons.favorite_border,
                  texto: '140 MIL',
                  aoTocar: () {
                    mostrarMensagem(context, 'Você curtiu o Reel!');
                  }),
                BotaoReel(
                  icone: Icons.comment_outlined,
                  texto: '67',
                  aoTocar: () {
                    mostrarMensagem(context, 'Você comentou no Reel!');
                  },
                ),
                BotaoReel(
                  icone: Icons.send,
                  texto: 'Compartilhar',
                  aoTocar: () {
                    mostrarMensagem(context, 'Você compartilhou o Reel!');
                  },
                ),
              ],
            )
          )
        ],
      )    
    );
  }
}