import 'package:flutter/material.dart';

class ColoringTemplate {
  final String id;
  final String name;
  final String category;
  final int difficulty; // 1: Kolay (2-4 yaş), 2: Orta (5-7 yaş), 3: Zor (8-9 yaş)
  final String description;
  final List<TemplatePath> paths;
  final Color primaryColor;
  final String? imagePath; // PNG resim dosyası yolu

  ColoringTemplate({
    required this.id,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.description,
    required this.paths,
    required this.primaryColor,
    this.imagePath,
  });
}

class TemplatePath {
  final Path path;
  final String name;
  final Color? suggestedColor;

  TemplatePath({
    required this.path,
    required this.name,
    this.suggestedColor,
  });
}

class TemplateProvider {
  static List<ColoringTemplate> getTemplatesByCategory(String category) {
    switch (category) {
      case 'animals':
        return _getAnimalTemplates();
      case 'fruits':
        return _getFruitTemplates();
      case 'vehicles':
        return _getVehicleTemplates();
      case 'shapes':
        return _getShapeTemplates();
      case 'free_draw':
        return _getFreeDrawTemplates();
      default:
        return [];
    }
  }

  static List<ColoringTemplate> _getAnimalTemplates() {
    return [
      // Hayvan şablonları - 10 adet
      ColoringTemplate(
        id: 'hayvan1',
        name: 'Hayvan 1',
        category: 'animals',
        difficulty: 1,
        description: 'Sevimli hayvan',
        primaryColor: Colors.orange,
        imagePath: 'assets/images/animals/hayvan1.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan2',
        name: 'Hayvan 2',
        category: 'animals',
        difficulty: 1,
        description: 'Sevimli hayvan',
        primaryColor: Colors.brown,
        imagePath: 'assets/images/animals/hayvan2.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan3',
        name: 'Hayvan 3',
        category: 'animals',
        difficulty: 2,
        description: 'Sevimli hayvan',
        primaryColor: Colors.grey,
        imagePath: 'assets/images/animals/hayvan3.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan4',
        name: 'Hayvan 4',
        category: 'animals',
        difficulty: 2,
        description: 'Sevimli hayvan',
        primaryColor: Colors.black,
        imagePath: 'assets/images/animals/hayvan4.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan5',
        name: 'Hayvan 5',
        category: 'animals',
        difficulty: 2,
        description: 'Sevimli hayvan',
        primaryColor: Colors.pink,
        imagePath: 'assets/images/animals/hayvan5.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan6',
        name: 'Hayvan 6',
        category: 'animals',
        difficulty: 3,
        description: 'Sevimli hayvan',
        primaryColor: Colors.green,
        imagePath: 'assets/images/animals/hayvan6.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan7',
        name: 'Hayvan 7',
        category: 'animals',
        difficulty: 3,
        description: 'Sevimli hayvan',
        primaryColor: Colors.blue,
        imagePath: 'assets/images/animals/hayvan7.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan8',
        name: 'Hayvan 8',
        category: 'animals',
        difficulty: 3,
        description: 'Sevimli hayvan',
        primaryColor: Colors.purple,
        imagePath: 'assets/images/animals/hayvan8.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan9',
        name: 'Hayvan 9',
        category: 'animals',
        difficulty: 2,
        description: 'Sevimli hayvan',
        primaryColor: Colors.teal,
        imagePath: 'assets/images/animals/hayvan9.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'hayvan10',
        name: 'Hayvan 10',
        category: 'animals',
        difficulty: 3,
        description: 'Sevimli hayvan',
        primaryColor: Colors.indigo,
        imagePath: 'assets/images/animals/hayvan10.png',
        paths: _createBasicPath(),
      ),
    ];
  }

  static List<ColoringTemplate> _getFruitTemplates() {
    return [
      // Meyve şablonları - 10 adet
      ColoringTemplate(
        id: 'meyve1',
        name: 'Meyve 1',
        category: 'fruits',
        difficulty: 1,
        description: 'Taze meyve',
        primaryColor: Colors.red,
        imagePath: 'assets/images/fruits/meyve1.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve2',
        name: 'Meyve 2',
        category: 'fruits',
        difficulty: 1,
        description: 'Taze meyve',
        primaryColor: Colors.yellow,
        imagePath: 'assets/images/fruits/meyve2.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve3',
        name: 'Meyve 3',
        category: 'fruits',
        difficulty: 1,
        description: 'Taze meyve',
        primaryColor: Colors.orange,
        imagePath: 'assets/images/fruits/meyve3.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve4',
        name: 'Meyve 4',
        category: 'fruits',
        difficulty: 2,
        description: 'Taze meyve',
        primaryColor: Colors.green,
        imagePath: 'assets/images/fruits/meyve4.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve5',
        name: 'Meyve 5',
        category: 'fruits',
        difficulty: 2,
        description: 'Taze meyve',
        primaryColor: Colors.purple,
        imagePath: 'assets/images/fruits/meyve5.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve6',
        name: 'Meyve 6',
        category: 'fruits',
        difficulty: 2,
        description: 'Taze meyve',
        primaryColor: Colors.pink,
        imagePath: 'assets/images/fruits/meyve6.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve7',
        name: 'Meyve 7',
        category: 'fruits',
        difficulty: 1,
        description: 'Taze meyve',
        primaryColor: Colors.brown,
        imagePath: 'assets/images/fruits/meyve7.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve8',
        name: 'Meyve 8',
        category: 'fruits',
        difficulty: 2,
        description: 'Taze meyve',
        primaryColor: Colors.lime,
        imagePath: 'assets/images/fruits/meyve8.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve9',
        name: 'Meyve 9',
        category: 'fruits',
        difficulty: 1,
        description: 'Taze meyve',
        primaryColor: Colors.teal,
        imagePath: 'assets/images/fruits/meyve9.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'meyve10',
        name: 'Meyve 10',
        category: 'fruits',
        difficulty: 2,
        description: 'Taze meyve',
        primaryColor: Colors.indigo,
        imagePath: 'assets/images/fruits/meyve10.png',
        paths: _createBasicPath(),
      ),
    ];
  }

  static List<ColoringTemplate> _getVehicleTemplates() {
    return [
      // Taşıt şablonları - 10 adet
      ColoringTemplate(
        id: 'tasit1',
        name: 'Taşıt 1',
        category: 'vehicles',
        difficulty: 2,
        description: 'Süper taşıt',
        primaryColor: Colors.red,
        imagePath: 'assets/images/vehicles/tasit1.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit2',
        name: 'Taşıt 2',
        category: 'vehicles',
        difficulty: 2,
        description: 'Süper taşıt',
        primaryColor: Colors.blue,
        imagePath: 'assets/images/vehicles/tasit2.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit3',
        name: 'Taşıt 3',
        category: 'vehicles',
        difficulty: 3,
        description: 'Süper taşıt',
        primaryColor: Colors.green,
        imagePath: 'assets/images/vehicles/tasit3.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit4',
        name: 'Taşıt 4',
        category: 'vehicles',
        difficulty: 3,
        description: 'Süper taşıt',
        primaryColor: Colors.yellow,
        imagePath: 'assets/images/vehicles/tasit4.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit5',
        name: 'Taşıt 5',
        category: 'vehicles',
        difficulty: 2,
        description: 'Süper taşıt',
        primaryColor: Colors.orange,
        imagePath: 'assets/images/vehicles/tasit5.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit6',
        name: 'Taşıt 6',
        category: 'vehicles',
        difficulty: 3,
        description: 'Süper taşıt',
        primaryColor: Colors.purple,
        imagePath: 'assets/images/vehicles/tasit6.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit7',
        name: 'Taşıt 7',
        category: 'vehicles',
        difficulty: 2,
        description: 'Süper taşıt',
        primaryColor: Colors.pink,
        imagePath: 'assets/images/vehicles/tasit7.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit8',
        name: 'Taşıt 8',
        category: 'vehicles',
        difficulty: 3,
        description: 'Süper taşıt',
        primaryColor: Colors.teal,
        imagePath: 'assets/images/vehicles/tasit8.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit9',
        name: 'Taşıt 9',
        category: 'vehicles',
        difficulty: 2,
        description: 'Süper taşıt',
        primaryColor: Colors.brown,
        imagePath: 'assets/images/vehicles/tasit9.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'tasit10',
        name: 'Taşıt 10',
        category: 'vehicles',
        difficulty: 3,
        description: 'Süper taşıt',
        primaryColor: Colors.indigo,
        imagePath: 'assets/images/vehicles/tasit10.png',
        paths: _createBasicPath(),
      ),
    ];
  }

  static List<ColoringTemplate> _getShapeTemplates() {
    return [
      // Şekil şablonları - 10 adet
      ColoringTemplate(
        id: 'sekil1',
        name: 'Şekil 1',
        category: 'shapes',
        difficulty: 1,
        description: 'Basit şekil',
        primaryColor: Colors.yellow,
        imagePath: 'assets/images/shapes/sekil1.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil2',
        name: 'Şekil 2',
        category: 'shapes',
        difficulty: 1,
        description: 'Basit şekil',
        primaryColor: Colors.red,
        imagePath: 'assets/images/shapes/sekil2.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil3',
        name: 'Şekil 3',
        category: 'shapes',
        difficulty: 1,
        description: 'Basit şekil',
        primaryColor: Colors.blue,
        imagePath: 'assets/images/shapes/sekil3.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil4',
        name: 'Şekil 4',
        category: 'shapes',
        difficulty: 2,
        description: 'Basit şekil',
        primaryColor: Colors.green,
        imagePath: 'assets/images/shapes/sekil4.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil5',
        name: 'Şekil 5',
        category: 'shapes',
        difficulty: 2,
        description: 'Basit şekil',
        primaryColor: Colors.orange,
        imagePath: 'assets/images/shapes/sekil5.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil6',
        name: 'Şekil 6',
        category: 'shapes',
        difficulty: 2,
        description: 'Basit şekil',
        primaryColor: Colors.purple,
        imagePath: 'assets/images/shapes/sekil6.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil7',
        name: 'Şekil 7',
        category: 'shapes',
        difficulty: 1,
        description: 'Basit şekil',
        primaryColor: Colors.pink,
        imagePath: 'assets/images/shapes/sekil7.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil8',
        name: 'Şekil 8',
        category: 'shapes',
        difficulty: 2,
        description: 'Basit şekil',
        primaryColor: Colors.teal,
        imagePath: 'assets/images/shapes/sekil8.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil9',
        name: 'Şekil 9',
        category: 'shapes',
        difficulty: 1,
        description: 'Basit şekil',
        primaryColor: Colors.brown,
        imagePath: 'assets/images/shapes/sekil9.png',
        paths: _createBasicPath(),
      ),
      ColoringTemplate(
        id: 'sekil10',
        name: 'Şekil 10',
        category: 'shapes',
        difficulty: 2,
        description: 'Basit şekil',
        primaryColor: Colors.indigo,
        imagePath: 'assets/images/shapes/sekil10.png',
        paths: _createBasicPath(),
      ),
    ];
  }

  static List<ColoringTemplate> _getFreeDrawTemplates() {
    return [
      // Serbest çizim için boş sayfa
      ColoringTemplate(
        id: 'free_draw',
        name: 'Serbest Çizim',
        category: 'free_draw',
        difficulty: 1,
        description: 'Hayal gücünü kullan ve istediğini çiz!',
        primaryColor: Colors.white,
        imagePath: null, // Boş sayfa için resim yok
        paths: _createEmptyPath(),
      ),
    ];
  }

  // Basit şablon path'leri - PNG resimler için placeholder
  static List<TemplatePath> _createBasicPath() {
    return [
      TemplatePath(
        path: _createRectanglePath(50, 50, 300, 400), // Genel boyama alanı
        name: 'Boyama Alanı',
        suggestedColor: Colors.transparent,
      ),
    ];
  }

  static List<TemplatePath> _createEmptyPath() {
    return [
      TemplatePath(
        path: _createRectanglePath(0, 0, 400, 600), // Tam sayfa
        name: 'Serbest Çizim Alanı',
        suggestedColor: Colors.white,
      ),
    ];
  }

  // Yardımcı fonksiyonlar
  static Path _createRectanglePath(double x, double y, double width, double height) {
    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(x, y, width, height),
      const Radius.circular(5),
    ));
    return path;
  }
}
