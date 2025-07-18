import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum BadgeType {
  firstDrawing('İlk Çizim', 'İlk boyama şablonunu tamamla', Icons.star, Colors.yellow),
  colorExplorer('Renk Kaşifi', '10 farklı renk kullan', Icons.palette, Colors.blue),
  artist('Sanatçı', '5 çizim tamamla', Icons.brush, Colors.purple),
  speedPainter('Hızlı Boyacı', '2 dakikada bir çizim tamamla', Icons.flash_on, Colors.orange),
  perfectionist('Mükemmeliyetçi', 'Silgi kullanmadan çizim tamamla', Icons.check_circle, Colors.green),
  creative('Yaratıcı', 'Serbest çizimde 50 farklı çizgi çek', Icons.auto_awesome, Colors.pink),
  persistent('Azimli', '3 gün üst üste boyama yap', Icons.trending_up, Colors.red),
  collector('Koleksiyoncu', '20 çizimi kaydet', Icons.collections, Colors.brown);

  const BadgeType(this.title, this.description, this.icon, this.color);

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

class Badge {
  final BadgeType type;
  final DateTime unlockedAt;
  final bool isUnlocked;

  Badge({
    required this.type,
    required this.unlockedAt,
    required this.isUnlocked,
  });

  factory Badge.locked(BadgeType type) {
    return Badge(
      type: type,
      unlockedAt: DateTime.now(),
      isUnlocked: false,
    );
  }

  factory Badge.unlocked(BadgeType type) {
    return Badge(
      type: type,
      unlockedAt: DateTime.now(),
      isUnlocked: true,
    );
  }
}

class BadgeProvider extends ChangeNotifier {
  final List<Badge> _badges = BadgeType.values
      .map((type) => Badge.locked(type))
      .toList();

  // İstatistikler
  int _completedDrawings = 0;
  int _usedColors = 0;
  int _fastDrawings = 0;
  int _perfectDrawings = 0;
  int _freeDrawingStrokes = 0;
  int _consecutiveDays = 0;
  int _savedDrawings = 0;
  DateTime? _lastDrawingDate;

  // Getters
  List<Badge> get badges => _badges;
  List<Badge> get unlockedBadges => _badges.where((b) => b.isUnlocked).toList();
  int get totalBadges => _badges.length;
  int get unlockedBadgeCount => unlockedBadges.length;

  // İstatistik getters
  int get completedDrawings => _completedDrawings;
  int get usedColors => _usedColors;
  int get savedDrawings => _savedDrawings;

  // Rozet kontrolü
  void checkBadges() {
    // İlk çizim rozetini kontrol et
    if (_completedDrawings >= 1) {
      _unlockBadge(BadgeType.firstDrawing);
    }

    // Renk kaşifi rozetini kontrol et
    if (_usedColors >= 10) {
      _unlockBadge(BadgeType.colorExplorer);
    }

    // Sanatçı rozetini kontrol et
    if (_completedDrawings >= 5) {
      _unlockBadge(BadgeType.artist);
    }

    // Hızlı boyacı rozetini kontrol et
    if (_fastDrawings >= 1) {
      _unlockBadge(BadgeType.speedPainter);
    }

    // Mükemmeliyetçi rozetini kontrol et
    if (_perfectDrawings >= 1) {
      _unlockBadge(BadgeType.perfectionist);
    }

    // Yaratıcı rozetini kontrol et
    if (_freeDrawingStrokes >= 50) {
      _unlockBadge(BadgeType.creative);
    }

    // Azimli rozetini kontrol et
    if (_consecutiveDays >= 3) {
      _unlockBadge(BadgeType.persistent);
    }

    // Koleksiyoncu rozetini kontrol et
    if (_savedDrawings >= 20) {
      _unlockBadge(BadgeType.collector);
    }
  }

  void _unlockBadge(BadgeType type) {
    final index = _badges.indexWhere((b) => b.type == type);
    if (index != -1 && !_badges[index].isUnlocked) {
      _badges[index] = Badge.unlocked(type);
      notifyListeners();
      // Burada rozet kazanma animasyonu veya sesi tetiklenebilir
      _showBadgeUnlockedNotification(type);
    }
  }

  void _showBadgeUnlockedNotification(BadgeType type) {
    if (kDebugMode) {
      print('🏆 Rozet kazandın: ${type.title}');
    }
    // TODO: Rozet kazanma animasyonu ve sesi
  }

  // İstatistik güncellemeleri
  void onDrawingCompleted({bool wasFast = false, bool wasPerfect = false}) {
    _completedDrawings++;
    
    if (wasFast) _fastDrawings++;
    if (wasPerfect) _perfectDrawings++;

    // Günlük takip
    final today = DateTime.now();
    if (_lastDrawingDate == null || 
        !_isSameDay(_lastDrawingDate!, today)) {
      if (_lastDrawingDate != null && 
          _isConsecutiveDay(_lastDrawingDate!, today)) {
        _consecutiveDays++;
      } else {
        _consecutiveDays = 1;
      }
      _lastDrawingDate = today;
    }

    checkBadges();
    notifyListeners();
  }

  void onColorUsed(Color color) {
    // Basit renk sayma (daha sofistike olabilir)
    _usedColors = (_usedColors + 1).clamp(0, 20);
    checkBadges();
  }

  void onFreeDrawingStroke() {
    _freeDrawingStrokes++;
    checkBadges();
  }

  void onDrawingSaved() {
    _savedDrawings++;
    checkBadges();
    notifyListeners();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  bool _isConsecutiveDay(DateTime lastDate, DateTime currentDate) {
    final difference = currentDate.difference(lastDate).inDays;
    return difference == 1;
  }

  // Progress hesaplama
  double getBadgeProgress(BadgeType type) {
    switch (type) {
      case BadgeType.firstDrawing:
        return _completedDrawings >= 1 ? 1.0 : _completedDrawings / 1.0;
      case BadgeType.colorExplorer:
        return (_usedColors / 10.0).clamp(0.0, 1.0);
      case BadgeType.artist:
        return (_completedDrawings / 5.0).clamp(0.0, 1.0);
      case BadgeType.speedPainter:
        return _fastDrawings >= 1 ? 1.0 : 0.0;
      case BadgeType.perfectionist:
        return _perfectDrawings >= 1 ? 1.0 : 0.0;
      case BadgeType.creative:
        return (_freeDrawingStrokes / 50.0).clamp(0.0, 1.0);
      case BadgeType.persistent:
        return (_consecutiveDays / 3.0).clamp(0.0, 1.0);
      case BadgeType.collector:
        return (_savedDrawings / 20.0).clamp(0.0, 1.0);
    }
  }

  // Test için sıfırlama
  void resetProgress() {
    _completedDrawings = 0;
    _usedColors = 0;
    _fastDrawings = 0;
    _perfectDrawings = 0;
    _freeDrawingStrokes = 0;
    _consecutiveDays = 0;
    _savedDrawings = 0;
    _lastDrawingDate = null;

    for (int i = 0; i < _badges.length; i++) {
      _badges[i] = Badge.locked(_badges[i].type);
    }

    notifyListeners();
  }
}
