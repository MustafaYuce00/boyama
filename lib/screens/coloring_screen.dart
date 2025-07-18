import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/coloring_provider.dart';
import '../widgets/drawing_canvas.dart';
import '../widgets/color_palette.dart';
import '../widgets/tool_bar.dart';
import '../models/coloring_template.dart';

class ColoringScreen extends StatefulWidget {
  final String category;
  final ColoringTemplate? template;
  
  const ColoringScreen({super.key, required this.category, this.template});

  @override
  State<ColoringScreen> createState() => _ColoringScreenState();
}

class _ColoringScreenState extends State<ColoringScreen> {
  @override
  void initState() {
    super.initState();
    // Ekran açıldığında sesli karşılama (gelecekte eklenecek)
    _playWelcomeSound();
  }

  void _playWelcomeSound() {
    // TODO: Sesli karşılama ekle
    // "Merhaba! Boyama yapmaya hazır mısın?"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          _getCategoryTitle(widget.category),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: _getCategoryColor(widget.category),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white, size: 30),
            onPressed: () {
              HapticFeedback.mediumImpact();
              _saveDrawing();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Araç çubuğu
          Container(
            color: _getCategoryColor(widget.category),
            child: const ToolBar(),
          ),
          
          // Ana çizim alanı
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: DrawingCanvas(template: widget.template),
              ),
            ),
          ),
          
          // Renk paleti
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: const ColorPalette(),
          ),
        ],
      ),
    );
  }

  String _getCategoryTitle(String category) {
    switch (category) {
      case 'animals':
        return '🐱 Hayvanlar';
      case 'fruits':
        return '🍎 Meyveler';
      case 'vehicles':
        return '🚗 Taşıtlar';
      case 'shapes':
        return '🌟 Şekiller';
      case 'free':
        return '✏️ Serbest Çizim';
      default:
        return '🎨 Boyama';
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'animals':
        return Colors.orange;
      case 'fruits':
        return Colors.red;
      case 'vehicles':
        return Colors.blue;
      case 'shapes':
        return Colors.purple;
      case 'free':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  void _saveDrawing() {
    // TODO: Çizimi kaydet
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text(
              '🎉 Harika! Sanat eserin kaydedildi!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    
    // Başarı sesi çal (gelecekte eklenecek)
    HapticFeedback.heavyImpact();
  }
}
