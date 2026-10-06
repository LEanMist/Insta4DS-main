import 'package:flutter/material.dart';
import 'package:instagram_flutter/theme/app_theme.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  String pesquisar = '';

  final List<String> assuntos = const [
    'Flutter',
    'Dart',
    'Mobile',
    'Programação',
    'Tecnologia',
    'Design',
    'Faculdade',
    'Projetos',
    'Carreira',
  ];

  @override
  Widget build(BuildContext context) {
    final resultado = assuntos
        .where((item) => item.toLowerCase().contains(pesquisar.toLowerCase()))
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              onChanged: (texto) {
                setState(() {
                  pesquisar = texto;
                });
              },
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                prefixIcon: Icon(Icons.search, color: AppColors.purple),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: resultado.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),

                itemBuilder: (context, indice) {
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
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.code, color: AppColors.white, size: 38),
                        const SizedBox(height: 8),
                        Text(
                          resultado[indice],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
