import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'theme/app_theme.dart';

class InstagramApp extends StatelessWidget {
    const InstagramApp({super.key});

    @override
    Widget build(BuildContext context){
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'InstaAula',
          theme: AppTheme.light(),
          home: const LoginPage(),
      );
    } 
}