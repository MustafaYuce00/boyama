import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/coloring_provider.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColoringProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Silgi
              _buildToolButton(
                context: context,
                icon: Icons.cleaning_services,
                label: 'Silgi',
                isSelected: provider.isErasing,
                color: Colors.grey[600]!,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  provider.toggleEraser();
                  _playToolSound();
                },
              ),

              // Fırça kalınlığı
              _buildBrushSizeButton(context, provider),

              // Geri al
              _buildToolButton(
                context: context,
                icon: Icons.undo,
                label: 'Geri Al',
                isSelected: false,
                color: Colors.blue[600]!,
                onTap: () {
                  HapticFeedback.lightImpact();
                  provider.undo();
                  _playToolSound();
                },
              ),

              // Tümünü temizle
              _buildToolButton(
                context: context,
                icon: Icons.clear_all,
                label: 'Temizle',
                isSelected: false,
                color: Colors.red[600]!,
                onTap: () {
                  HapticFeedback.heavyImpact();
                  _showClearConfirmation(context, provider);
                },
              ),

              // Yeni şablon
              _buildToolButton(
                context: context,
                icon: Icons.refresh,
                label: 'Yeni',
                isSelected: false,
                color: Colors.green[600]!,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  _showNewTemplateDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToolButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? color : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrushSizeButton(BuildContext context, ColoringProvider provider) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _showBrushSizeDialog(context, provider);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.brush,
              color: Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              'Fırça',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBrushSizeDialog(BuildContext context, ColoringProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '🖌️ Fırça Boyutu',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Önizleme
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Container(
                        width: provider.strokeWidth,
                        height: provider.strokeWidth,
                        decoration: BoxDecoration(
                          color: provider.selectedColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Slider
                  Slider(
                    value: provider.strokeWidth,
                    min: 2.0,
                    max: 20.0,
                    divisions: 18,
                    label: provider.strokeWidth.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        provider.setStrokeWidth(value);
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Tamam',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  void _showClearConfirmation(BuildContext context, ColoringProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '🗑️ Tümünü Temizle',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Tüm çizimi silmek istediğin emin misin?\nBu işlem geri alınamaz!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Hayır',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                provider.clearAll();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🧹 Tüm çizim temizlendi!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text(
                'Evet',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  void _showNewTemplateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '🆕 Yeni Şablon',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Yeni bir boyama şablonu seçmek ister misin?\nMevcut çizimin kaybolacak!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'İptal',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Ana sayfaya dön
                Navigator.pop(context);
              },
              child: const Text(
                'Yeni Şablon',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  void _playToolSound() {
    // TODO: Araç ses efekti
    // Küçük bir "tık" sesi çalacak
  }
}
