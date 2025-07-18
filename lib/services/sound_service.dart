import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _soundEnabled = true;

  // Ses açık/kapalı durumu
  bool get soundEnabled => _soundEnabled;

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
  }

  // Çeşitli ses efektleri
  Future<void> playColorSelectSound() async {
    if (!_soundEnabled) return;
    
    try {
      // Basit tık sesi (programatik olarak oluşturulmuş)
      await _audioPlayer.play(AssetSource('sounds/color_select.mp3'));
    } catch (e) {
      if (kDebugMode) {
        print('Ses çalınamadı: $e');
      }
    }
  }

  Future<void> playBrushSound() async {
    if (!_soundEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sounds/brush_stroke.mp3'));
    } catch (e) {
      if (kDebugMode) {
        print('Fırça sesi çalınamadı: $e');
      }
    }
  }

  Future<void> playSuccessSound() async {
    if (!_soundEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sounds/success.mp3'));
    } catch (e) {
      if (kDebugMode) {
        print('Başarı sesi çalınamadı: $e');
      }
    }
  }

  Future<void> playButtonClickSound() async {
    if (!_soundEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sounds/button_click.mp3'));
    } catch (e) {
      if (kDebugMode) {
        print('Buton tık sesi çalınamadı: $e');
      }
    }
  }

  Future<void> playWelcomeSound() async {
    if (!_soundEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sounds/welcome.mp3'));
    } catch (e) {
      if (kDebugMode) {
        print('Karşılama sesi çalınamadı: $e');
      }
    }
  }

  // Sesli yönlendirmeler (gelecekte eklenecek)
  Future<void> playVoiceInstruction(String instruction) async {
    if (!_soundEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sounds/voice/$instruction.mp3'));
    } catch (e) {
      if (kDebugMode) {
        print('Sesli yönlendirme çalınamadı: $e');
      }
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

// Sesli yönlendirme metinleri (farklı diller için)
class VoiceInstructions {
  static const Map<String, Map<String, String>> instructions = {
    'tr': {
      'welcome': 'Merhaba! Boyama yapmaya hazır mısın?',
      'color_selected': 'Güzel renk seçimi!',
      'good_job': 'Harika! Çok güzel boyuyorsun!',
      'drawing_saved': 'Tebrikler! Sanat eserin kaydedildi!',
      'clear_warning': 'Dikkat! Tüm çizimin silinecek.',
      'undo_action': 'Son çizim geri alındı.',
    },
    'en': {
      'welcome': 'Hello! Are you ready to color?',
      'color_selected': 'Great color choice!',
      'good_job': 'Amazing! You are coloring beautifully!',
      'drawing_saved': 'Congratulations! Your artwork is saved!',
      'clear_warning': 'Warning! All your drawing will be deleted.',
      'undo_action': 'Last drawing undone.',
    },
  };

  static String getInstruction(String key, [String language = 'tr']) {
    return instructions[language]?[key] ?? instructions['tr']?[key] ?? '';
  }
}
