import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/coloring_provider.dart';
import 'providers/badge_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColoringProvider()),
        ChangeNotifierProvider(create: (_) => BadgeProvider()),
      ],
      child: MaterialApp(
        title: 'Boyama Kitabı',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFD54F), // Cıvıl cıvıl sarı
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Comic Sans MS', // Çocuklar için daha uygun font
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
/*
sıkıntıları var
mesela resimler taşıyor 
cizgi boyutlari bagimsiz olmasi lazim
*/
