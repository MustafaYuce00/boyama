import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'coloring_screen.dart';
import 'template_selection_screen.dart';
import 'badge_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFD54F), // Cıvıl cıvıl sarı
              Color(0xFF4FC3F7), // Mavi
              Color(0xFF81C784), // Yeşil
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Başlık
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '🎨 BOYAMA KİTABI 🎨',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // Alt başlık
              Text(
                'Yaş: 2-9 👶👧👦',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Şablon kategorileri
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildCategoryCard(
                      context,
                      '🐱 Hayvanlar',
                      Colors.orange,
                      Icons.pets,
                      'animals',
                    ),
                    _buildCategoryCard(
                      context,
                      '🍎 Meyveler',
                      Colors.red,
                      Icons.apple,
                      'fruits',
                    ),
                    _buildCategoryCard(
                      context,
                      '🚗 Taşıtlar',
                      Colors.blue,
                      Icons.directions_car,
                      'vehicles',
                    ),
                    _buildCategoryCard(
                      context,
                      '🌟 Şekiller',
                      Colors.purple,
                      Icons.star,
                      'shapes',
                    ),
                    _buildCategoryCard(
                      context,
                      '✏️ Serbest Çizim',
                      Colors.green,
                      Icons.brush,
                      'free_draw',
                    ),
                  ],
                ),
              ),
              
              // Alt butonlar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          context,
                          '✏️ Serbest Çizim',
                          Colors.green,
                          () => _navigateToColoring(context, 'free'),
                        ),
                        _buildActionButton(
                          context,
                          '📋 Kaydedilenler',
                          Colors.deepOrange,
                          () => _showSavedDrawings(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          context,
                          '🏆 Rozetlerim',
                          Colors.amber,
                          () => _navigateToBadges(context),
                        ),
                        _buildActionButton(
                          context,
                          '⚙️ Ayarlar',
                          Colors.blueGrey,
                          () => _showSettings(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, Color color, 
      IconData icon, String category) {
    return GestureDetector(
      onTap: () {
        // Ses efekti çal
        HapticFeedback.lightImpact();
        _navigateToColoring(context, category);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String title, Color color, 
      VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _navigateToColoring(BuildContext context, String category) {
    if (category == 'free') {
      // Serbest çizim için direkt boyama ekranına git
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ColoringScreen(category: category),
        ),
      );
    } else {
      // Diğer kategoriler için şablon seçimi ekranına git
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TemplateSelectionScreen(category: category),
        ),
      );
    }
  }

  void _showSavedDrawings(BuildContext context) {
    // TODO: Kaydedilen çizimleri göster
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎨 Kaydedilen çizimler yakında eklenecek!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _navigateToBadges(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BadgeScreen(),
      ),
    );
  }

  void _showSettings(BuildContext context) {
    // TODO: Ayarlar sayfası
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('⚙️ Ayarlar sayfası yakında eklenecek!'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
