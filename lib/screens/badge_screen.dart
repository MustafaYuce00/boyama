import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/badge_provider.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          '🏆 Rozet Koleksiyonum',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<BadgeProvider>(
        builder: (context, badgeProvider, child) {
          return Column(
            children: [
              // İstatistik kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                          '🎨',
                          '${badgeProvider.completedDrawings}',
                          'Tamamlanan\nÇizim',
                        ),
                        _buildStatCard(
                          '🏆',
                          '${badgeProvider.unlockedBadgeCount}/${badgeProvider.totalBadges}',
                          'Kazanılan\nRozet',
                        ),
                        _buildStatCard(
                          '💾',
                          '${badgeProvider.savedDrawings}',
                          'Kaydedilen\nÇizim',
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: badgeProvider.unlockedBadgeCount / badgeProvider.totalBadges,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 8,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '%${((badgeProvider.unlockedBadgeCount / badgeProvider.totalBadges) * 100).round()} Tamamlandı',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Rozet listesi
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: badgeProvider.badges.length,
                  itemBuilder: (context, index) {
                    final badge = badgeProvider.badges[index];
                    final progress = badgeProvider.getBadgeProgress(badge.type);
                    return _buildBadgeCard(badge, progress);
                  },
                ),
              ),

              // Alt butonlar
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          _showBadgeInfo(context);
                        },
                        icon: const Icon(Icons.info),
                        label: const Text('Rozet Rehberi'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (badgeProvider.unlockedBadgeCount > 0)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            _shareAchievements(context, badgeProvider);
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Paylaş'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeCard(Badge badge, double progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Rozet ikonu
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: badge.isUnlocked 
                    ? badge.type.color.withOpacity(0.2)
                    : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                badge.type.icon,
                size: 30,
                color: badge.isUnlocked 
                    ? badge.type.color
                    : Colors.grey[400],
              ),
            ),

            const SizedBox(width: 16),

            // Rozet bilgileri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        badge.type.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: badge.isUnlocked 
                              ? Colors.black87
                              : Colors.grey[600],
                        ),
                      ),
                      if (badge.isUnlocked)
                        const SizedBox(width: 8),
                      if (badge.isUnlocked)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    badge.type.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Progress bar
                  if (!badge.isUnlocked)
                    Column(
                      children: [
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(badge.type.color),
                          minHeight: 6,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(progress * 100).round()}% Tamamlandı',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  
                  // Kazanılma tarihi
                  if (badge.isUnlocked)
                    Text(
                      'Kazanıldı: ${_formatDate(badge.unlockedAt)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showBadgeInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '🏆 Rozet Rehberi',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: Text(
              'Rozetler, boyama uygulamasında çeşitli görevleri tamamlayarak kazanabileceğin özel ödüllerdir!\n\n'
              '• Her rozet farklı bir başarıyı temsil eder\n'
              '• Rozetleri kazanarak ilerleme kaydet\n'
              '• Arkadaşlarınla başarılarını paylaş\n'
              '• Yeni rozetler için farklı aktiviteler dene\n\n'
              'Bol eğlenceler dileriz! 🎨',
              style: TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Anladım!',
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

  void _shareAchievements(BuildContext context, BadgeProvider badgeProvider) {
    // TODO: Sosyal paylaşım özelliği
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🎉 ${badgeProvider.unlockedBadgeCount} rozet kazandın! Paylaşım özelliği yakında...',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
