import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ColoringProvider extends ChangeNotifier {
  Color _selectedColor = const Color(0xFFFF5722); // Başlangıç rengi - turuncu
  List<ui.Offset?> _points = [];
  List<Color> _pointColors = [];
  double _strokeWidth = 8.0;
  bool _isErasing = false;
  
  // Çocuklar için özel renk paleti
  final List<Color> _colorPalette = [
    const Color(0xFFFF5722), // Turuncu
    const Color(0xFFFFD54F), // Sarı
    const Color(0xFF4FC3F7), // Mavi
    const Color(0xFF81C784), // Yeşil
    const Color(0xFFE91E63), // Pembe
    const Color(0xFF9C27B0), // Mor
    const Color(0xFFFF9800), // Koyu Turuncu
    const Color(0xFF795548), // Kahverengi
    const Color(0xFF607D8B), // Gri-Mavi
    const Color(0xFFF44336), // Kırmızı
    const Color(0xFF00BCD4), // Cyan
    const Color(0xFF8BC34A), // Açık Yeşil
  ];

  // Getters
  Color get selectedColor => _selectedColor;
  List<ui.Offset?> get points => _points;
  List<Color> get pointColors => _pointColors;
  double get strokeWidth => _strokeWidth;
  bool get isErasing => _isErasing;
  List<Color> get colorPalette => _colorPalette;

  // Renk seçimi
  void selectColor(Color color) {
    _selectedColor = color;
    _isErasing = false;
    notifyListeners();
  }

  // Fırça kalınlığı ayarla
  void setStrokeWidth(double width) {
    _strokeWidth = width;
    notifyListeners();
  }

  // Silgi modunu aç/kapat
  void toggleEraser() {
    _isErasing = !_isErasing;
    if (_isErasing) {
      _selectedColor = Colors.white;
    }
    notifyListeners();
  }

  // Nokta ekle (çizim yaparken)
  void addPoint(ui.Offset point) {
    _points.add(point);
    _pointColors.add(_selectedColor);
    notifyListeners();
  }

  // Çizgi sonlandır (parmak kaldırıldığında)
  void endStroke() {
    _points.add(null);
    _pointColors.add(Colors.transparent);
    notifyListeners();
  }

  // Tümünü temizle
  void clearAll() {
    _points.clear();
    _pointColors.clear();
    notifyListeners();
  }

  // Son çizimi geri al
  void undo() {
    if (_points.isNotEmpty) {
      // Son null değerine kadar olan tüm noktaları sil
      int lastNullIndex = _points.lastIndexOf(null);
      if (lastNullIndex != -1) {
        _points.removeRange(lastNullIndex, _points.length);
        _pointColors.removeRange(lastNullIndex, _pointColors.length);
      } else {
        // Eğer null yoksa, tüm listeyi temizle
        _points.clear();
        _pointColors.clear();
      }
      notifyListeners();
    }
  }
}
