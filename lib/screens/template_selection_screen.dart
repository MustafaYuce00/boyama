import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/coloring_template.dart';
import 'coloring_screen.dart';

class TemplateSelectionScreen extends StatelessWidget {
  final String category;
  
  const TemplateSelectionScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final templates = TemplateProvider.getTemplatesByCategory(category);
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          _getCategoryTitle(category),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: _getCategoryColor(category),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Kategori açıklaması
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _getCategoryColor(category),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Text(
                  _getCategoryDescription(category),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '${templates.length} şablon mevcut',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Şablon listesi
          Expanded(
            child: templates.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      return _buildTemplateCard(context, templates[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(BuildContext context, ColoringTemplate template) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ColoringScreen(
              category: category,
              template: template,
            ),
          ),
        );
      },
      child: Container(
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
        child: Column(
          children: [
            // Şablon önizlemesi
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Center(
                  child: CustomPaint(
                    painter: TemplatePreviewPainter(template),
                    size: const Size(120, 120),
                  ),
                ),
              ),
            ),
            
            // Şablon bilgileri
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ...List.generate(3, (index) => Icon(
                          Icons.star,
                          size: 14,
                          color: index < template.difficulty 
                              ? Colors.amber 
                              : Colors.grey[300],
                        )),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: template.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getDifficultyText(template.difficulty),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: template.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.palette_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Henüz şablon yok',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Bu kategori için şablonlar yakında eklenecek!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
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
      case 'free_draw':
        return '✏️ Serbest Çizim';
      default:
        return '🎨 Şablonlar';
    }
  }

  String _getCategoryDescription(String category) {
    switch (category) {
      case 'animals':
        return 'Sevimli hayvan arkadaşlarını boyayalım!';
      case 'fruits':
        return 'Lezzetli meyveleri renklendirelim!';
      case 'vehicles':
        return 'Harika araçları boyayalım!';
      case 'shapes':
        return 'Eğlenceli şekilleri renklendirelim!';
      case 'free_draw':
        return 'Hayal gücünü kullan ve istediğini çiz!';
      default:
        return 'Güzel şablonları boyayalım!';
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
      case 'free_draw':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  String _getDifficultyText(int difficulty) {
    switch (difficulty) {
      case 1:
        return 'Kolay';
      case 2:
        return 'Orta';
      case 3:
        return 'Zor';
      default:
        return '';
    }
  }
}

// Şablon önizleme çizer
class TemplatePreviewPainter extends CustomPainter {
  final ColoringTemplate template;

  TemplatePreviewPainter(this.template);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Şablonun küçük önizlemesini çiz
    canvas.save();
    canvas.scale(0.6); // Küçült
    
    for (final templatePath in template.paths) {
      canvas.drawPath(templatePath.path, paint);
    }
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
