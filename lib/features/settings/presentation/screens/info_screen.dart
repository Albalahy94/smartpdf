import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class InfoScreen extends StatelessWidget {
  final String title;
  final String content;

  const InfoScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    AppTheme.obsidianBlack,
                    AppTheme.obsidianBlack,
                  ]
                : [
                    AppTheme.lightSurface,
                    Colors.white,
                  ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.deepSlateCard : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? AppTheme.borderDark : Colors.grey[200]!,
                  width: isDark ? 1.2 : 1,
                ),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
