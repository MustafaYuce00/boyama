import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/coloring_provider.dart';

class ColorPalette extends StatelessWidget {
  const ColorPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColoringProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Başlık
              const Text(
                '🎨 Renkler',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              
              // Renk seçenekleri
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: provider.colorPalette.length,
                  itemBuilder: (context, index) {
                    final color = provider.colorPalette[index];
                    final isSelected = provider.selectedColor == color && !provider.isErasing;
                    
                    return GestureDetector(
                      onTap: () {
                        // Haptic feedback
                        HapticFeedback.lightImpact();
                        
                        // Renk seçimi ses efekti (gelecekte eklenecek)
                        _playColorSelectSound();
                        
                        provider.selectColor(color);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey[300]!,
                            width: isSelected ? 4 : 2,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: color.withOpacity(0.5),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _playColorSelectSound() {
    // TODO: Renk seçimi ses efekti
    // Küçük bir "tık" sesi çalacak
  }
}

// Özel renk seçici widget'ı
class CustomColorPicker extends StatelessWidget {
  const CustomColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColoringProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '🌈 Özel Renk Seç',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              // Basit renk seçici (daha gelişmiş bir tane eklenebilir)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...Colors.primaries.map((color) => GestureDetector(
                    onTap: () {
                      provider.selectColor(color);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  )),
                ],
              ),
              
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kapat'),
              ),
            ],
          ),
        );
      },
    );
  }
}
